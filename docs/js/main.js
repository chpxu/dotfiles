// // This is a function which directly manipulates the DOM on first click.
// // This means anchors are destroyed and regenerated once every click,
const fileDownload = document.getElementById("file-download");
const osContent = ["void-content", "nixos-content"];
const nixPaths = [
  `https://github.com/chpxu/dotfiles/blob/nixfiles/.config/alacritty/${fileNames[0]}`,
  `https://github.com/chpxu/dotfiles/blob/nixfiles/.config/BetterDiscord/themes/${fileNames[1]}`,
  `https://github.com/chpxu/dotfiles/blob/nixfiles/.config/BetterDiscord/themes/${fileNames[2]}`,
];
const fileNames = ["alacritty.yml", "nord-zelk.theme.css", "zelkBD.theme.css"];
// This function only merely generates the HTMl.  This function does not modify CSS.
let anchor = document
    .createElement("a")
    .setAttribute("target", "_blank")
    .setAttribute("download", true);

    // Generate the divs "nixos-content" and "void-content"
let divNix = document.createElement("div").setAttribute("id", osContent[1]);
let divVoid = document.createElement("div").setAttribute("id", osContent[0]);
function generateIdDiv(id) {
  let div = document.createElement("div");
  div.setAttribute("id", id);
  fileDownload.appendChild(div);
  // Make the header
  div.appendChild(document.createElement("h4").createTextNode(id + ":"));
  div.appendChild(divNix);
  div.appendChild(divVoid);
}
function generateNixContent(id, path, filename) {
  generateIdDiv(id);
  
  anchor.createTextNode(filename).setAttribute("href", path);
}
function generateVoidContent(id, path, filename) {
  generateIdDiv(id);
  anchor.createTextNode(filename).setAttribute("href", path);
}
