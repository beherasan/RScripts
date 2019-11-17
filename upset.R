library(turner)

library(ComplexHeatmap)

data <- read.csv("MaleFlower_merged_count_upset.txt",sep="\t",row.names = 1,header=TRUE)

#lt=list(set1 = c("a", "b", "c"),
#     set2 = c("b", "c", "d", "e"),
#     set3 = c("a","d","f"))
#lt
#list_to_matrix(lt)
#head(data)
m = make_comb_mat(data)
#UpSet(m)
#comb_size(m)
#UpSet(m, set_order = c("a", "b", "c"), comb_order = order(comb_size(m)))
UpSet(m, pt_size = unit(6, "mm"),lwd = 3,comb_col = c("#3071a9", "#2b542c","#d9534f","#5bc0de","#0275d8")[comb_degree(m)],
      top_annotation = HeatmapAnnotation(
          "Intersection size" = anno_barplot(
            comb_size(m), 
            border = FALSE, 
            #gp = gpar(fill = "black"),
            gp = gpar(fill = c("#3071a9", "#2b542c","#d9534f","#5bc0de","#0275d8")[comb_degree(m)]),
            height = unit(2, "cm"),
            bar_width = 1,
            axis_param = list(side = "right"),
            text=c("a","b")
          ), 
          annotation_name_side = "right", 
          annotation_name_rot = 0, height=unit(100, "mm")),
      right_annotation = upset_right_annotation(m, 
                                          gp = gpar(fill = "black"),
                                          annotation_name_side = "bottom",
                                          axis_param = list(side = "bottom"),height=unit(20, "cm")))
