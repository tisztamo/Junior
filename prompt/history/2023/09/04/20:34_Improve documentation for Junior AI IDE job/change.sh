#!/bin/sh
set -e
goal="Improve documentation for Junior AI IDE job"
echo "Plan:"
echo "1. Append detailed offer to the open_jobs.md file."
echo "2. Ensure readability, clarity, and comprehension."

# Append the detailed offer
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

**Our Offer:**
- A **0.1% share for every candidate** who gets selected for an in-person interview.
- **1%** of Krisztián's share (which stands at 95% of the total shares currently) will be allocated to the selected candidate at the start of their tenure. This will be followed by the same percentage allocation every month during the first 12 months of collaboration. (This will be calculated and transferred on the 1st of the subsequent month)
- Terms and conditions of this offer are negotiable.

Interested candidates or those who can connect us to potential candidates are encouraged to reach out. Together, we can make Junior AI IDE a groundbreaking success.
EOF

echo "\033[32mDone: $goal\033[0m\n"