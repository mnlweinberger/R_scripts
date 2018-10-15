file_list = list.files("~/Desktop/Mouse_brain_NEW_tRNAs")
print(file_list)
class(file_list)
browser()
for (f in file_list){
  trna <-f
  f=sprintf('%s/%s','~/Desktop/Mouse_brain_NEW_tRNAs',f)
  table = read.table(file = f,header = F)
  #test <- ("~/Desktop/Sec_test_tRNA")
  #table = read.table(file = "~/Desktop/Sec_test_tRNA",header = F)
  iodine <- table$V2
  untreated <- table$V3
  sequence <- table$V1
  over_0.1=table$V6
  over_0.1 = as.character(over_0.1)
  over_0.1[over_0.1 == '_'] = ' '
  name = sprintf('%s/%s.pdf','~/Desktop/Mouse_brain_NEW_tRNAs_output',trna)
  pdf(file = name)
  plot(iodine, type="h", col="red", ylim=c(0,1), xlab=NA, ylab=NA, xaxt='n')
  # plot type="h" is histogram and "l" is line!
  #xlab=NA, ylab=NA -> I want to set my own X/Y not to have them chosen for me!
  lines(untreated, type="h", lty=3, col="blue")
  title(xlab="position", col.lab=rgb(0,0,0), cex.lab=0.75) # set X axis
  title(ylab="mutation rate", col.lab=rgb(0,0,0), cex.lab=0.75) # set Y axis
  print(over_0.1[1])
  # cex controls size of label!!!
  axis(side=1, at=1:length(sequence), labels=sequence, lty=1, col="black", cex.axis=0.2)
  axis(side=3, at=1:length(sequence), labels=1:length(sequence), lty=1, col="black", cex.axis=0.3)
  text(x = 1:length(sequence), y = iodine, labels = over_0.1, pos = 3)
  par(new=T)
  coverage_i <- table$V4
  coverage_u <- table$V5
  height = 0
  a <- max(coverage_i)
  b <- max(coverage_u)
  if(a>b) {
    height = a
  } else {
    height =b
  }
  plot(coverage_u, type="l", lty=2, col="green", axes=F, ylim=c(0,height), xlab=NA, ylab=NA,  xaxt='n') 
  lines(coverage_i, type="l", lty=4, col="purple", axes=F, xlab=NA, ylab=NA) 
  #axes=F to make sure I don't obsqure the original Y axis with the new one
  axis(side=4)
  mtext(side=4, line=3,"coverage")
  
  
  legend("topleft",c("Iodine","Untreated","Coverage Iodine","Coverage untreated"),  lty=c(1,1), cex=0.75, col=c("red","blue","green","purple"))
  title(sprintf("Mutation rates and coverage in iodine vs. untreated \n %s \n", trna), cex.title=0.75)
  dev.off()
}
