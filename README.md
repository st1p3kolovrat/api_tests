## API Tests Setup Guide

### 🛠 **Framework and Tools**  
- **Framework**: [Behave](https://behave.readthedocs.io/en/latest/)  
- **Language**: [Gherkin](https://cucumber.io/docs/gherkin/reference/), Python (Running on 3.11.6. Had issues using multiple 3.12.+ versions)  
- **Test Style**: BDD (Behavior-Driven Development)
- **IDE**: Recommended [PyCharm](https://www.jetbrains.com/pycharm/), but you can use any other based on you preference
- **URL**: [Petstore](https://petstore.swagger.io/)

---

### 📂 **Setup Instructions**

#### 1. **Install Dependencies**  
Install required libraries with:  
```bash
pip3 install -r requirements.txt
```
---

### ▶️ **Running Tests Locally**

### **Run All Tests**  
To execute all tests, type in your terminal:  
```bash
behave
```

### **Run a Specific Group of Tests**  
Run tests using tags:  
This will run tests that contains only this tag
```bash
behave --tags @add_new_pet
```

