##########################################################################
# Methylation heatmap
##########################################################################
plot.meth.heatmap <- function(filename){
  if(!exists("mdata") | !exists("mdiff")){
    stop("ERROR: data not loaded. Please run loadMethData and make sure mdiff exists.")
  }
  
  mdata.sig <- mdata[rownames(mdiff)[1:1000],]
  
  m.annot <- data.frame(
    pack.years=mpheno$smoking_group,
    age.group=mpheno$age_group,
    gender=mpheno$Gender,
    COPD=substr(mpheno$COPD, 1,1),
    status=mpheno$Sample_Group
  )
  m.annot_colors <- list(
    status=c(Progressive=pr.cols[2], Regressive=pr.cols[1], Control=pr.cols[3]),
    pack.years=smoking_group_names,
    age.group=age_group_names,
    gender=c("F"="pink", "M"="lightblue"),
    COPD=c("N"="darkgreen", "Y"="orange")
  )
  rownames(m.annot) <- colnames(mdata.sig)
  
  pdf(filename)
  pheatmap(mdata.sig, cluster_rows=T, cluster_cols=T, scale="row", main=paste("Methylation (Top ",dim(mdata.sig)[1]," MVPs)", sep=""),
           annotation_col=m.annot, treeheight_row=0, treeheight_col=0, show_rownames=F, show_colnames=F,
           annotation_colors=m.annot_colors,
           color=hmcol2, legend=F)
  # Update following reviewer comments (WIP):
  # pheatmap(mdata.sig, cluster_rows=T, cluster_cols=T, scale="row", main=paste("Methylation (Top ",dim(mdata.sig)[1]," MVPs)", sep=""),
  #          annotation_col=m.annot, treeheight_row=0, treeheight_col=0, show_rownames=F, show_colnames=F,
  #          annotation_colors=m.annot_colors,
  #          color=hmcol2, legend=T)
  dev.off()
}

