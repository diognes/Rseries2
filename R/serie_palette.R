# serie palette function
# enter name, palette of preference, number, type

serie_palette <- function(name, palette_color = palette_netflyx, n, type = c("discrete", "continuous")) {
  
  pal <- palette_color[name][[1]]
  
  
  if (is.null(pal)){ 
    stop("Palette not found.")
  }
  
  if (missing(n)) { 
    n <- length(pal)
  }
  
  if (missing(type)) {
    if(n > length(pal)){type <- "continuous"}
    else{ type <- "discrete"}
  }
  type <- match.arg(type)
  
  
  if (type == "discrete" && n > length(pal)) {
    stop("Number of requested colors greater than what discrete palette can offer, \n  use as continuous instead.")
  }
  
  
  out <- switch(type,
                continuous = grDevices::colorRampPalette(pal[1:3])(n),

                discrete = pal[c(1:n)],
  )
  structure(out, class = "serie_palette", name = name)
}


print.serie_palette <- function(x, ...) {
  pallength <- length(x)
  latinpar <- par(mar=c(0.25,0.25,0.25,0.25))
  on.exit(par(latinpar))
  
  image(1:pallength, 1,
        as.matrix(1:pallength),
        col = x,
        axes=FALSE)
  
  rect(0, 0.9, pallength + 1, 1.1, col = rgb(1, 1, 1, 0.8), border = NA)
  text(median(1:pallength), 1,
       labels = paste0(attr(x,"name"),", n=",pallength),
       cex = 3, family = "sans")
}

 is.serie_palette <- function(x) {
   inherits(x, "serie_palette")
 }

