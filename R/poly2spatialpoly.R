#library(rgdal)

#' Convert a polygon dataframe in the format used by ggplot2::geom_polygon to a spatialPolygonDataFrame
#'
#' Assumes that the dataframe only contains rombuses.
#'
#' @param polydf A polygon in the format required by geom_polygon: a data.frame with values, x and y positions and id labels
#' @return A spatialPolygonsDataFrame object, as used in the package 'sp'
#' @export

poly2sp <- function(polydf) {

   require(sp)
   polydf <- polydf[!is.na(polydf$value), ]
   num_ids <- length(polydf$id)
   values <- polydf$value[seq(1, num_ids*4, by=4)]
   ids <- polydf$id[seq(1, num_ids*4, by=4)]
   num_ids <- length(ids)
   SP <- vector("list", length(values))
   val <- values
   nids <- ids
   count <- 0

   pb <- txtProgressBar(min = 0, max = length(values), style = 3)
   for (item in 1:num_ids) {
      #d <- polydf[which(polydf$id == ids[item]),]
      d <- polydf[(1+(item-1)*4):(item*4), ]
      x <- c(d$x, d$x[1])
      y <- c(d$y, d$y[1])
      if (!any(is.na(x))) {
         count <- count + 1
         sP <- sp::Polygon(cbind(x,y))
         SP[[count]] <- sp::Polygons(list(sP), ids[item])
         val[count] <- values[item]
         nids[count] <- ids[item]
      }
      setTxtProgressBar(pb,item)
   }
   close(pb)
   SP <- SP[1:count]
   val <- val[1:count]
   nids <- ids[1:count]
   att <- data.frame(value=val, row.names=nids)
   SPP <- sp::SpatialPolygons(SP, 1:count)
   sPdf <- sp::SpatialPolygonsDataFrame(SPP, att)
}

#' Convert a SpatialPolygonDataFrame to a raster. (Wrapper for raster::rasterize() with some reasonable defaults for the ereefs package)
#'
#' @param sPdf SpatialPolygonDataFrame object, e.g. as output by poly2sp.
#' @param xmn Minimum x value to use for the grid. Defaults to 142.45
#' @param ymn Minimum y value for the grid. Defaults to -27.5
#' @param resolution Grid resolution in degrees. Defaults to 0.01
#' @param xmax Maximum x value for the grid. Defaults to max value from the SpatialPolygonDataFrame bounding box.
#' @param ymax Maximum y value for the grid. Defaults to max value from the SpatialPolygonDataFrame bounding box.
#' @return A SpatialPolygonsDataFrame object, as used in the package 'sp'
#' @export

sp2raster <- function(sPdf, xmn=142.45, ymn=-27.5, resolution=0.01, xmx=NA, ymx=NA, r=NULL) { 
   # Default settings line up with Dieter's grid but encompass full extent of eReefs domain
  sPdf <- sPdf
   bbox <- summary(sPdf)$bbox
   if (is.na(xmx)) xmx<-bbox['x','max']
   if (is.na(ymx)) ymx<-bbox['y','max']
   ncols <- as.integer((xmx-xmn)/resolution)
   nrows <- as.integer((ymx-ymn)/resolution)
   xmx <- xmn + resolution * ncols
   ymx <- ymn + resolution * nrows
   if (is.null(r)) r <- raster::raster(ncol=ncols, nrow=nrows, xmn=xmn, xmx=xmx, ymn=ymn, ymx=ymx)
   r <- raster::rasterize(sPdf, r, field='value')
}

