## PROBLEM SOURCE: https://rpubs.com/kateto/netviz


nodes <- read.csv("R/dataVisualization/data/Dataset1-Media-Example-NODES.csv", header=T, as.is=T)
links <- read.csv("R/dataVisualization/data/Dataset1-Media-Example-EDGES.csv", header=T, as.is=T)


View(nodes)
View(links)
## Find number of Nodes
nrow(nodes); length(unique(nodes$id))
nrow(links); nrow(unique(links[,c("from","to")]))

links <- aggregate(links[,3], links[,-3], sum)
links <- links[order(links$from, links$to),]
colnames(links)[4] <- "weight"
rownames(links) <- NULL

## Dataset 2 - Matrix
nodes2 <- read.csv("R/dataVisualization/data/Dataset2-Media-User-Example-NODES.csv", header=T, as.is=T)
links2 <- read.csv("R/dataVisualization/data/Dataset2-Media-User-Example-EDGES.csv", header=T, row.names=1)

head(nodes2)
head(links2)

links2 <- as.matrix(links2)
dim(links2)
dim(nodes2)

library(igraph)
net <- graph.data.frame(links, nodes, directed=T)
net

E(net)
V(net)
E(net)$type
V(net)$media

net[1,]
net[5,7]

plot(net)

## Remove Loops
simplify(net, remove.loops = T, remove.multiple = F)

plot(net, edge.arrow.size = .4, vertex.label = NA)

## Plot with node names
plot(net, edge.arrow.size=.2, edge.color="orange",
     vertex.color="gray50", vertex.frame.color="#ffffff",
     vertex.label=V(net)$media, vertex.label.color="black")

## Color the nodes based on Media Type
colrs <- c("gray50", "tomato", "gold")
V(net)$color <- colrs[V(net)$media.type]

plot(net, edge.arrow.size=.2, edge.color="orange",
     vertex.color=V(net)$color, vertex.frame.color="#ffffff",
     vertex.label=V(net)$media, vertex.label.color="black")

## Node size varies with size of audience
V(net)$size = V(net)$audience.size*0.6

## Now you want to know strength of Relationship based on Weight
E(net)$width <- E(net)$weight/6

## Regenerate the plot
plot(net, edge.arrow.size=.2, edge.color="orange",
     vertex.color=V(net)$color, vertex.frame.color="#ffffff",
     vertex.label=V(net)$media, vertex.label.color="black")

## Add Legend
legend(x=-1.5, y=-1.1, c("Newspaper","Television", "Online News"), pch=21,
       col="#777777", pt.bg=colrs, pt.cex=2, cex=.8, bty="n", ncol=1)


