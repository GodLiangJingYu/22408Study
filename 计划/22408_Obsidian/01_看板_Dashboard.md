---
type: dashboard
project: 22408
cssclasses: dashboard
---

<style>
/* Modern Minimalist Dashboard Styling */
.dashboard-container {
    max-width: 900px;
    margin: 0 auto;
    font-family: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
    color: var(--text-normal);
}
.kpi-header {
    margin-top: 2rem;
    margin-bottom: 3rem;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
}
.kpi-title {
    font-size: 0.9rem;
    text-transform: uppercase;
    letter-spacing: 0.1em;
    color: var(--text-muted);
    margin-bottom: 0.5rem;
}
.kpi-stats {
    font-size: 3rem;
    font-weight: 300;
    line-height: 1;
    margin-bottom: 1rem;
}
.progress-bar {
    width: 100%;
    max-width: 400px;
    height: 4px;
    background: var(--background-modifier-border);
    border-radius: 2px;
    overflow: hidden;
}
.progress-fill {
    height: 100%;
    background: var(--text-normal);
    transition: width 0.5s ease;
}
.day-card {
    background: var(--background-secondary);
    border-radius: 12px;
    padding: 1.5rem 2rem;
    margin-bottom: 1.5rem;
    box-shadow: 0 4px 12px rgba(0,0,0,0.02);
    border: 1px solid var(--background-modifier-border);
}
.day-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1px solid var(--background-modifier-border);
    padding-bottom: 0.75rem;
    margin-bottom: 1rem;
}
.day-title {
    font-size: 1.2rem;
    font-weight: 500;
}
.day-date {
    font-size: 0.85rem;
    color: var(--text-muted);
}
.task-group {
    margin-top: 1rem;
}
.task-group-title {
    font-size: 0.8rem;
    text-transform: uppercase;
    letter-spacing: 0.05em;
    color: var(--text-muted);
    margin-bottom: 0.5rem;
}
.task-list {
    margin-left: 0;
    padding-left: 0;
    list-style: none;
}
.task-list li {
    margin-bottom: 0.5rem;
    font-size: 0.95rem;
}
.task-list input[type="checkbox"] {
    margin-right: 0.75rem;
    accent-color: var(--text-normal);
}
.empty-state {
    color: var(--text-faint);
    font-size: 0.9rem;
    font-style: italic;
}
</style>

```dataviewjs
// Minimalist Weekly Dashboard
const container = dv.container;
container.innerHTML = "";

const wrap = container.createEl("div", { cls: "dashboard-container" });

// 1. Fetch Tasks
const allPages = dv.pages('"22408_Obsidian"');
let allTasks = [];
for (const p of allPages) {
    if (p.file.tasks) allTasks = allTasks.concat(p.file.tasks);
}

// 2. Date Setup
const today = window.moment();
const startOfWeek = today.clone().startOf('isoWeek');
const endOfWeek = today.clone().endOf('isoWeek');

// 3. Filter Week Tasks
const weekTasks = allTasks.filter(t => {
    if (!t.due) return false;
    const due = window.moment(t.due.toString());
    if (!due.isValid()) return false;
    return due.isBetween(startOfWeek, endOfWeek, 'day', '[]');
});

const totalTasks = weekTasks.length;
const doneTasks = weekTasks.filter(t => t.completed).length;
const progress = totalTasks > 0 ? (doneTasks / totalTasks) * 100 : 0;

// 4. Render Header (Progress)
const headerHtml = `
    <div class="kpi-header">
        <div class="kpi-title">Current Week Progress</div>
        <div class="kpi-stats">${doneTasks} / ${totalTasks}</div>
        <div class="progress-bar">
            <div class="progress-fill" style="width: ${progress}%"></div>
        </div>
    </div>
`;
wrap.innerHTML += headerHtml;

// 5. Extract Tags for grouping
const getSubjectTag = (tags) => {
    if (!tags || tags.length === 0) return "Other";
    const subjectTags = tags.filter(t => t.includes("#math") || t.includes("#408") || t.includes("#english") || t.includes("#politics"));
    return subjectTags.length > 0 ? subjectTags[0] : "Other";
};

// 6. Render Days
const days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];

days.forEach((dayName, index) => {
    const currentDay = startOfWeek.clone().add(index, 'days');
    const dateStr = currentDay.format("YYYY-MM-DD");
    const isToday = currentDay.isSame(today, 'day');
    
    const dayTasks = weekTasks.filter(t => window.moment(t.due.toString()).isSame(currentDay, 'day'));
    
    const dayCard = wrap.createEl("div", { cls: "day-card" });
    dayCard.innerHTML = `
        <div class="day-header">
            <div class="day-title">${dayName} ${isToday ? '(Today)' : ''}</div>
            <div class="day-date">${currentDay.format("MMM D")}</div>
        </div>
    `;
    
    if (dayTasks.length === 0) {
        dayCard.innerHTML += `<div class="empty-state">Rest day. No tasks scheduled.</div>`;
    } else {
        // Group by Subject
        const grouped = {};
        dayTasks.forEach(t => {
            const subject = getSubjectTag(t.tags);
            if (!grouped[subject]) grouped[subject] = [];
            grouped[subject].push(t);
        });
        
        for (const [subject, tasks] of Object.entries(grouped)) {
            const groupDiv = dayCard.createEl("div", { cls: "task-group" });
            groupDiv.innerHTML = `<div class="task-group-title">${subject.replace("#", "")}</div>`;
            dv.taskList(tasks, false, groupDiv);
        }
    }
});
```