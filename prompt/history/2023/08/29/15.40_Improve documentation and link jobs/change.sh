#!/bin/sh
set -e
goal="Improve documentation and link jobs"
echo "Plan:"
echo "1. Remove advisor's name and translate 'helyi nagyágyú'."
echo "2. Link the jobs from the sidebar."

# 1. Remove advisor's name and translate 'helyi nagyágyú'.
cat > docs/open_jobs.md << 'EOF'
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
EOF

# 2. Link the jobs from the sidebar.
cat > docs/_sidebar.md << 'EOF'
* [Junior Docs](./README.md)
* [Usage](./usage.md)
* [Web](./web.md)
* [Prompt Descriptor](./descriptor.md)
* [Roadmap](./roadmap.md)
* [Open Jobs](./open_jobs.md)
EOF

echo "\033[32mDone: $goal\033[0m\n"