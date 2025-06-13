<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Club Activity Proposal</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="style.css">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            background: linear-gradient(to bottom right, #edf2f7, #dfe9f3);
        }
        .form-container {
            width: 90%;
            max-width: 1000px;
            margin: 10px auto;
            background: white;
            border-radius: 12px;
            padding: 10px 40px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
        }
        h2.section-title {
            font-size: 24px;
            margin-bottom: 10px;
            border-left: 6px solid #FFD93D;
            padding-left: 15px;
        }
        .form-group {
            margin-bottom: 10px;
        }
        label {
            font-weight: 600;
            display: block;
            margin-bottom: 6px;
        }
        input[type="text"],
        input[type="datetime-local"],
        input[type="number"],
        select,
        textarea {
            width: 100%;
            padding: 10px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }
        textarea {
            resize: vertical;
        }
        .step-nav {
            display: flex;
            justify-content: space-between;
            margin-top: 30px;
        }
        .step-nav button {
            padding: 10px 25px;
            border: none;
            border-radius: 6px;
            font-weight: 600;
            cursor: pointer;
        }
        .step-nav .back-btn {
            background: #ccc;
        }
        .step-nav .next-btn {
            background: #4285f4;
            color: white;
        }
        .step {
            display: none;
        }
        .step.active {
            display: block;
        }
        .checkbox-group label {
            display: block;
            margin: 5px 0;
        }
    </style>
</head>
<body>
<div class="form-container">
    <form action="ActivityProposalServlet" method="post" enctype="multipart/form-data">
        <!-- Step 1 -->
        <div class="step active">
            <h2 class="section-title">Basic Information</h2>
            <div class="form-group">
                <label>Event Title</label>
                <input type="text" name="eventTitle" required>
            </div>
            <div class="form-group">
                <label>Club Name</label>
                <select name="clubName" required>
                    <option value="">-- Select Club --</option>
                    <option value="The Sound Club">The Sound Club</option>
                </select>
            </div>
            <div class="form-group">
                <label>Category</label>
                <select name="category" required>
                    <option value="">-- Select --</option>
                    <option value="Arts">Arts</option>
                    <option value="Academic">Academic</option>
                    <option value="Sports">Sports</option>
                </select>
            </div>
            <div class="form-group">
                <label>Start Date & Time</label>
                <input type="datetime-local" name="startDateTime" required>
            </div>
            <div class="form-group">
                <label>End Date & Time</label>
                <input type="datetime-local" name="endDateTime" required>
            </div>
            <div class="form-group">
                <label>Venue</label>
                <input type="text" name="venue" required>
            </div>
            <div class="form-group">
                <label>Participant Limit</label>
                <input type="number" name="participantLimit" value="100" required>
            </div>
        </div>

        <!-- Step 2 -->
        <div class="step">
            <h2 class="section-title">Objectives & Description</h2>
            <div class="form-group">
                <label>Event Objectives</label>
                <textarea name="objectives" required></textarea>
            </div>
            <div class="form-group">
                <label>Event Description</label>
                <textarea name="description" required></textarea>
            </div>
            <div class="form-group checkbox-group">
                <label>Target Audience:</label>
                <label><input type="checkbox" name="audience" value="UiTM"> All UiTM Students</label>
                <label><input type="checkbox" name="audience" value="Faculty"> Faculty</label>
                <label><input type="checkbox" name="audience" value="Public"> Open to public</label>
                <label><input type="checkbox" name="audience" value="Members"> Club members only</label>
            </div>
        </div>

        <!-- Step 3 -->
        <div class="step">
            <h2 class="section-title">Committee & Program Flow</h2>
            <div class="form-group">
                <label>Committee List (Role - Name - Student ID)</label>
                <textarea name="committeeList" placeholder="Event Director - Aina Safiya - 2023112345\n..." required></textarea>
            </div>
            <div class="form-group">
                <label>Upload Program Flow</label>
                <input type="file" name="programFlow">
            </div>
        </div>

        <!-- Step 4 -->
        <div class="step">
            <h2 class="section-title">Budget & Promotion</h2>
            <div class="form-group">
                <label>Total Budget (RM)</label>
                <input type="number" name="budget" required>
            </div>
            <div class="form-group">
                <label>Upload Budget Breakdown</label>
                <input type="file" name="budgetFile">
            </div>
            <div class="form-group">
                <label>Promotion Strategy</label>
                <textarea name="promotionStrategy"></textarea>
            </div>
            <div class="form-group">
                <label>Upload Poster / Visual</label>
                <input type="file" name="poster">
            </div>
        </div>

        <!-- Navigation Buttons -->
        <div class="step-nav">
            <button type="button" class="back-btn" onclick="prevStep()">Back</button>
            <button type="button" class="next-btn" onclick="nextStep()">Next</button>
            <button type="submit" class="next-btn" style="display:none;">Submit</button>
        </div>
    </form>
</div>

<script>
    const steps = document.querySelectorAll('.step');
    const backBtn = document.querySelector('.back-btn');
    const nextBtn = document.querySelector('.next-btn');
    const submitBtn = document.querySelector('button[type="submit"]');
    let currentStep = 0;

    function showStep(step) {
        steps.forEach((s, i) => s.classList.toggle('active', i === step));
        backBtn.style.display = step > 0 ? 'inline-block' : 'none';
        nextBtn.style.display = step < steps.length - 1 ? 'inline-block' : 'none';
        submitBtn.style.display = step === steps.length - 1 ? 'inline-block' : 'none';
    }

    function nextStep() {
        if (currentStep < steps.length - 1) {
            currentStep++;
            showStep(currentStep);
        }
    }

    function prevStep() {
        if (currentStep > 0) {
            currentStep--;
            showStep(currentStep);
        }
    }

    showStep(currentStep);
</script>
</body>
</html>
