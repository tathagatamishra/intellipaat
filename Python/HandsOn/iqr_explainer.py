import matplotlib.pyplot as plt
import matplotlib.patches as mpatches
import numpy as np

fig, ax = plt.subplots(figsize=(14, 8))

# ---- Build a sample distribution ----
np.random.seed(1)
data = np.concatenate([
    np.random.normal(50, 10, 500),   # main body
    np.array([5, 8, 92, 95, 98])     # a few outliers
])
data = np.sort(data)

# True-ish quartiles for the drawing
Q1 = np.percentile(data, 25)
Q3 = np.percentile(data, 75)
IQR = Q3 - Q1
lower = Q1 - 1.5 * IQR
upper = Q3 + 1.5 * IQR
median = np.median(data)

# ---- Boxplot ----
bp = ax.boxplot(data, vert=False, positions=[1], widths=0.35,
                patch_artist=True,
                boxprops=dict(facecolor="#cfe8ff", edgecolor="#1565c0", linewidth=2),
                medianprops=dict(color="#c62828", linewidth=2.5),
                whiskerprops=dict(color="#1565c0", linewidth=2),
                capprops=dict(color="#1565c0", linewidth=2),
                flierprops=dict(marker="o", markerfacecolor="#ff7043",
                                markeredgecolor="#bf360c", markersize=9))

# ---- Scatter the raw points under the box for context ----
y_jitter = 0.18 + np.random.uniform(-0.02, 0.02, size=len(data))
ax.scatter(data, y_jitter, s=12, color="#90a4ae", alpha=0.5, zorder=1)

# ---- Vertical reference lines for each key value ----
key_points = {
    lower:  ("Lower fence\nQ1 - 1.5*IQR", "#6a1b9a"),
    Q1:     ("Q1  (25%)", "#1565c0"),
    median: ("Median", "#c62828"),
    Q3:     ("Q3  (75%)", "#1565c0"),
    upper:  ("Upper fence\nQ3 + 1.5*IQR", "#6a1b9a"),
}
for x, (label, color) in key_points.items():
    ax.axvline(x, color=color, linestyle="--", linewidth=1.4, alpha=0.85, zorder=2)

# ---- Annotate each key point ----
label_y = 1.55
offsets = {lower: -0.02, Q1: 0.0, median: 0.0, Q3: 0.0, upper: 0.02}
for x, (label, color) in key_points.items():
    ax.annotate(label, xy=(x, 1.18), xytext=(x, label_y),
                ha="center", fontsize=10.5, color=color, fontweight="bold",
                arrowprops=dict(arrowstyle="-", color=color, lw=1))
    ax.annotate(f"{x:0.1f}", xy=(x, 0.62), ha="center",
                fontsize=9, color=color)

# ---- Highlight the IQR span ----
ax.annotate("", xy=(Q3, 0.35), xytext=(Q1, 0.35),
            arrowprops=dict(arrowstyle="<->", color="#2e7d32", lw=2))
ax.text((Q1 + Q3) / 2, 0.28, f"IQR = Q3 - Q1  =  {IQR:0.1f}",
        ha="center", color="#2e7d32", fontweight="bold", fontsize=11)

# ---- Outlier zone shading ----
ax.axvspan(data.min() - 2, lower, color="#ffcccc", alpha=0.35)
ax.axvspan(upper, data.max() + 2, color="#ffcccc", alpha=0.35)
ax.text(lower - 6, 0.85, "OUTLIERS\n(removed)", ha="center",
        color="#b71c1c", fontweight="bold", fontsize=10)
ax.text(upper + 6, 0.85, "OUTLIERS\n(removed)", ha="center",
        color="#b71c1c", fontweight="bold", fontsize=10)

# ---- Title with the formula in code form ----
ax.set_title(
    "Outlier Removal with the IQR (Interquartile Range) Method\n",
    fontsize=15, fontweight="bold"
)
formula = ("for col in outlier_columns:\n"
           "    Q1 = df[col].quantile(0.25)\n"
           "    Q3 = df[col].quantile(0.75)\n"
           "    IQR = Q3 - Q1\n"
           "    lower = Q1 - 1.5 * IQR\n"
           "    upper = Q3 + 1.5 * IQR\n"
           "    df = df[(df[col] >= lower) & (df[col] <= upper)]")
fig.text(0.5, 0.02, formula, fontsize=11.5,
         ha="center", family="monospace",
         bbox=dict(boxstyle="round,pad=0.6",
                   facecolor="#f5f5f5", edgecolor="#9e9e9e"))

# ---- Cosmetic ----
ax.set_ylim(0.1, 1.9)
ax.set_xlim(data.min() - 12, data.max() + 12)
ax.set_yticks([])
ax.set_xlabel("value", fontsize=11)
for spine in ["top", "right", "left"]:
    ax.spines[spine].set_visible(False)

plt.tight_layout(rect=[0, 0.30, 1, 1])
plt.savefig("iqr_explainer.png", dpi=140, bbox_inches="tight")
print("saved: iqr_explainer.png")
