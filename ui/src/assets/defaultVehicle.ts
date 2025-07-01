// Default vehicle placeholder image (can be replaced with actual vehicle images)
const defaultVehicleImage = 'data:image/svg+xml;base64,' + btoa(`
<svg width="120" height="80" viewBox="0 0 120 80" fill="none" xmlns="http://www.w3.org/2000/svg">
  <rect width="120" height="80" fill="#f0f0f0"/>
  <path d="M20 50 L30 40 L90 40 L100 50 L100 60 L90 65 L30 65 L20 60 Z" fill="#004a00"/>
  <circle cx="35" cy="60" r="8" fill="#333"/>
  <circle cx="85" cy="60" r="8" fill="#333"/>
  <circle cx="35" cy="60" r="5" fill="#666"/>
  <circle cx="85" cy="60" r="5" fill="#666"/>
  <rect x="40" y="45" width="40" height="10" fill="#5fbc60"/>
</svg>
`);

export default defaultVehicleImage;
