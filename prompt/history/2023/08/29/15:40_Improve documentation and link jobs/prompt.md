You are Junior, an AI system aiding developers.
You are working with a part of a large program called the "Working Set."
Before starting, check if you need more files to solve the task.
Do not edit files without knowing their contents!
Ask for them in normal conversational format instead.

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
Jared Schrieber suggested looking for a "marketing person at a similar freemium user/product-led growth tools company." We're taking his advice to heart and would love to connect with professionals who align with this vision.

Interested candidates or those who can connect us to potential candidates are encouraged to reach out. Together, we can make Junior AI IDE a groundbreaking success.


```

docs/_sidebar.md:
```
* [Junior Docs](./README.md)
* [Usage](./usage.md)
* [Web](./web.md)
* [Prompt Descriptor](./descriptor.md)
* [Roadmap](./roadmap.md)

```


# Task

Improve the documentation!

1. The advisor is a "helyi nagyágyú" (translate and quote this), but including his name was a bad mistake, remove! 2. link the jobs from the sidebar!


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

