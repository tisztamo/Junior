import tailwindcss from 'tailwindcss';
import autoprefixer from 'autoprefixer';
import postcssNested from 'postcss-nested';

export default function postCssConfig() {
  return {
    plugins: [
      postcssNested(),
      tailwindcss(),
      autoprefixer()
    ]
  }
}
