from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, EmailStr

app = FastAPI(
    title="Student Management API",
    description="A practical FastAPI project demonstrating HTTP methods",
    version="1.0.0"
)

class Student(BaseModel):
    name: str
    age: int
    course: str
    email: EmailStr

students = {}

@app.get("/")
def home():
    return {"message": "Welcome to Student Management API"}

@app.get("/students")
def get_students():
    return {"students": students}

@app.get("/students/{student_id}")
def get_student(student_id: int):
    if student_id not in students:
        raise HTTPException(status_code=404, detail="Student not found")
    return students[student_id]

@app.post("/students", status_code=201)
def create_student(student_id: int, student: Student):
    if student_id in students:
        raise HTTPException(status_code=400, detail="Student ID already exists")
    students[student_id] = student.model_dump()
    return {
        "message": "Student created successfully",
        "student_id": student_id,
        "student": students[student_id]
    }

@app.put("/students/{student_id}")
def update_student(student_id: int, student: Student):
    if student_id not in students:
        raise HTTPException(status_code=404, detail="Student not found")
    students[student_id] = student.model_dump()
    return {
        "message": "Student completely updated",
        "student_id": student_id,
        "student": students[student_id]
    }

class StudentUpdate(BaseModel):
    name: str | None = None
    age: int | None = None
    course: str | None = None
    email: EmailStr | None = None

@app.patch("/students/{student_id}")
def partial_update_student(student_id: int, student: StudentUpdate):
    if student_id not in students:
        raise HTTPException(status_code=404, detail="Student not found")
    update_data = student.model_dump(exclude_unset=True)
    students[student_id].update(update_data)
    return {
        "message": "Student partially updated",
        "student_id": student_id,
        "student": students[student_id]
    }

@app.delete("/students/{student_id}")
def delete_student(student_id: int):
    if student_id not in students:
        raise HTTPException(status_code=404, detail="Student not found")
    deleted_student = students.pop(student_id)
    return {
        "message": "Student deleted successfully",
        "student_id": student_id,
        "student": deleted_student
    }
