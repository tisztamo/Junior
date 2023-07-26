const path = require('path');
const tailwindcss = require('tailwindcss');
const autoprefixer = require('autoprefixer');
const postcssNested = require('postcss-nested');

module.exports = {
  plugins: {
    'tailwindcss/nesting': postcssNested,
    tailwindcss: { config: path.join(__dirname, 'tailwind.config.cjs') },
    autoprefixer: autoprefixer,
  },
};
