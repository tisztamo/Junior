const tailwindcss = require('tailwindcss');
const autoprefixer = require('autoprefixer');
const postcssImport = require('postcss-import');
const postcssNested = require('postcss-nested');

module.exports = {
  plugins: {
    'postcss-import': {},
    'tailwindcss/nesting': postcssNested,
    tailwindcss: { config: './src/frontend/tailwind.config.cjs' },
    autoprefixer: autoprefixer,
  },
};
