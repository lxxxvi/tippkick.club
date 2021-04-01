module.exports = {
  purge: [
    "./app/views/**/*"
  ],
  darkMode: false, // or 'media' or 'class'
  theme: {
    extend: {
      fontSize: {
        "2xs": ".625rem"
      }
    },
  },
  variants: {
    extend: {
      backgroundColor: ['checked'],
      borderColor: ['checked']
    },
  },
  plugins: [
    require('@tailwindcss/forms'),
  ],
}
