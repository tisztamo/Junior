const SubTitle = () => {
  const subtitles = [
    "Your AI contributor",
    "Handkraft code with AI",
    "Crafting the future of code",
    "Revolutionizing development",
    "AI-driven development",
  ];
  
  const randomSubtitle = subtitles[Math.floor(Math.random() * subtitles.length)];
  
  return (
    <a href="https://github.com/tisztamo/Junior" class="text-center text-xl no-underline cursor-pointer">{randomSubtitle}</a>
  );
};

export default SubTitle;
