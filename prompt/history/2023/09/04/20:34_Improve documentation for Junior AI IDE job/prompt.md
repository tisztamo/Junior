You are AI Junior, you code like Donald Knuth.
# Working set

docs/open_jobs.md:
```
# Open Positions at Junior AI IDE

We're in the early stages of building an exciting startup based on our open source project, Junior AI IDE. Our primary goal right now is to find the right leadership to steer the ship and take our vision to the next level. Discover more about us at [aijunior.dev](https://aijunior.dev).

## Co-founder CEO

**Qualifications:**
- Proven experience in marketing within a freemium user/product-led growth environment, especially from similar tools companies.
- Strong networking abilities.
- Strong leadership qualities, with the ability to motivate, inspire, and build a team.

**Advice from Experts:**
A "local big gun" (translated from "helyi nagyágyú") suggested looking for a "marketing person at a similar freemium user/product-led growth tools company." We're taking this advice to heart and would love to connect with professionals who align with this vision.

Interested candidates or those who can connect us to potential candidates are encouraged to reach out. Together, we can make Junior AI IDE a groundbreaking success.

```


# Task

Improve the documentation!

Add details about my offer:

  - **0.1% share for every candidate** who gets selected for in-person interview.
  - **'1%** of my (Krisztián) share (which is 95% of all at the time) for the selected
  candidate' at the beginning of work,
  and every month during the first 12 months of work together.
  (Calculated and transferred at 1. of next month)
  - Terms are to be negotiated.

Make it easy to read, clear and understandable.
  
Ask if something is not described enough here!


Do not create backup files.

# Output Format

Encode and enclose your results as ./change.sh, a shell script that creates and changes files and does everything to solve the task.
Files are small, avoid using sed in favor of heredoc-ing full files using 'EOF' to prevent substitution.

OS: OSX

Installed tools: npm, jq


Do NOT write any text outside the script!

EXAMPLE START

```sh
#!/bin/sh
set -e
goal=[Task description, max 7 words]
echo "Plan:"
echo "1. [...]"
[Commands solving the task]
echo "\033[32mDone: $goal\033[0m\n"
```

EXAMPLE END

Before starting, check if you need more files to solve the task.
Do not edit any file not provided in the working set!
If you need more files, do not try to solve the task, ask for the missing files instead!

EXAMPLE START

`filepath1` is needed to solve the task but is not in the working set.

EXAMPLE END

