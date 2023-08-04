# Working set

src/frontend/styles/styles.css:
```
@import 'tailwindcss/base';
@import 'tailwindcss/components';
@import 'tailwindcss/utilities';
@import './markdown.css';

```

src/frontend/tailwind.config.cjs:
```
module.exports = {
  darkMode: 'class',
  content: [__dirname + '/**/*.html', __dirname + '/**/*.jsx'],
  theme: {
    screens: {
      'xs': '320px',
      'sm': '640px',
      'md': '768px',
      'lg': '1024px',
      'xl': '1280px',
      '2xl': '1536px',
    },
    extend: {
      spacing: {
        '72': '18rem',
        '84': '21rem',
        '96': '24rem',
        '128': '32rem',
      },
      fontSize: {
        'btn': '1.5rem',
      },
      padding: {
        'btn': '1.5rem',
      },
      maxWidth: {
        'desktop': '640px',
      },
      colors: {
        light: {
          text: '#1a202c',
          background: '#f7fafc',
          emphasize: '#e2e8f0', // New color for emphasizing a component
        },
        dark: {
          text: '#f7fafc',
          background: '#1a202c',
          emphasize: '#2d3748', // New color for emphasizing a component in dark mode
        },
      },
    },
  },
  variants: {
    extend: {},
  },
  plugins: [],
}

```


# Task

Implement the following feature!

- Create a plan!
- Create new files when needed!

Requirements:

Create styles/colors.css and import it from styles.css
Define CSS variables for the colors text, background and emphasize, with separate values for :root and for .dark
In tailwind config, use those variables instead of the constants, eliminate &#34;light&#34; and &#34;dark&#34; colors there and introduce the use of backgroundColor!
An example from the tailwind config of another project just to see what I mean:

colors: {
  primary: &#34;var(--primary-color)&#34;,
  line: &#34;var(--line-color)&#34;,
  main: &#34;var(--text-color)&#34;,
  ln2: &#34;var(--main-bg-2)&#34;,
  emphasize: &#34;var(--emphasize-color)&#34;
},
backgroundColor: {
  main: &#34;var(--main-bg)&#34;,
  main2: &#34;var(--main-bg-2)&#34;,
  chart: &#34;var(--chart-bg)&#34;,
  line: &#34;var(--line-color)&#34;,
},



## Project Specifics

- Every js file should *only export a single function*!
- Use *ES6 imports*!
- Prefer *async/await* over promises!
- The frontend uses *Solidjs*, edit .jsx file accordingly


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

