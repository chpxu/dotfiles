// This is a function which directly manipulates the DOM on first click.
const fileDownload = document.getElementById("file-download");
const osContent = ["void-content", "nixos-content"];

// Generate the divs "nixos-content" and "void-content"
let divNix = document.createElement("div");
divNix.setAttribute("id", osContent[1]);
let divVoid = document.createElement("div");
divVoid.setAttribute("id", osContent[0]);

function generateIdDiv(id) {
  let div = document.createElement("div");
  div.setAttribute("id", id);
  fileDownload.appendChild(div);
  // Make the header
  let header = document.createElement("h4");
  let headerText = document.createTextNode(id + ":");
  header.appendChild(headerText);
  div.appendChild(header);
  div.appendChild(divVoid);
  div.appendChild(divNix);
}
function generateOSContent(osDiv, paths, filenames) {
  paths.forEach((element, index) => {
    let anchor = document.createElement("a");
    anchor.setAttribute("target", "_blank");
    anchor.setAttribute("download", filenames[index]);
    anchor.setAttribute("class", "dl-links");

    let linkText = document.createTextNode(filenames[index]);
    anchor.appendChild(linkText);
    anchor.setAttribute("href", element);
    osDiv.appendChild(anchor);
  });
}
function generateContent(id, voidPaths, nixPaths, voidFilenames, nixFilenames) {
  generateIdDiv(id);
  generateOSContent(divVoid, voidPaths, voidFilenames);
  generateOSContent(divNix, nixPaths, nixFilenames);
}


// Alacritty
const alacrittyURLs = [
  [
    "https://raw.githubusercontent.com/chpxu/dotfiles/void/.config/alacritty/alacritty.yml"
  ],
  [""]
  // [
  //   "https://raw.githubusercontent.com/chpxu/dotfiles/void/.config/alacritty/alacritty.yml"
  // ]
];
generateContent(
  "alacritty",
  alacrittyURLs[0],
  alacrittyURLs[1],
  ["alacritty.yml"],
  [""]
);

// Waybar, since it has 3 items
const waybarURLs = [
  [
    "https://raw.githubusercontent.com/chpxu/dotfiles/void/.config/waybar/config.json",
    "https://raw.githubusercontent.com/chpxu/dotfiles/void/.config/waybar/style.css",
  ],
  [
    "https://raw.githubusercontent.com/chpxu/dotfiles/nixfiles/.config/waybar/config.jsonc",
    "https://raw.githubusercontent.com/chpxu/dotfiles/nixfiles/.config/waybar/style.css",
    "https://raw.githubusercontent.com/chpxu/dotfiles/nixfiles/.config/waybar/ydotool.sh",
  ]
];
generateContent(
  "waybar",
  waybarURLs[0],
  waybarURLs[1],
  ["void-config.jsonc", "void-style.css"],
  ["nixos-config.jsonc", "nixos-style.css", "nixos-ydotool.sh"]
);


