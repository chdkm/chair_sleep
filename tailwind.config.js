module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/assets/**/*.css',
    './app/javascript/**/*.js'
  ],

  plugins: [
    require("daisyui"),
  ],

  daisyui: {
    themes: ["retro"],
  },
}
