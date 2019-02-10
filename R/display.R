display <- function(version) {
  style = "
    position: absolute;
    top: 0;
    right: 0;
    width: auto;
    height: auto;
    background-color: #E0E0E0;
    padding: 3px 8px;
    font-size: 12px;"

  div(style = style, version)
}
