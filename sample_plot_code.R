# vector

x <- (1:5)^2
x[]
x[2]
x[c(2,5)]
x[c(2:5)] # inclusive
x[-1]
x[6]
x

# Vector: logical indexing

which(x>10)
which(x>10|x<20)
which(x>10 & x<20)
which(x<2 | x>20)

# array and matrix
arr1 <- array(1:12,
			  dim = c(2,2,3),
			  dimnames = list(
				c('First','Second'),
				c('A','B'),
				c('a','b','c')
			  )
		)

mat1 <- matrix(
			1:15,
			nrow = 3,
			ncol = 5,
			dimnames = list(
				c('a','b','c'),
				c('A','B','C','D','E')))

identical(arr1,mat1)

dim(mat1)
nrow(mat1)
ncol(mat1)
length(mat1)

rownames(mat1)
colnames(mat1)
t(mat1)

# list
l1 <- list('a' = 1,
		   'b',
		   'c' = array(c(1,2,3,4),dim = c(2,2)))

l1[1]
typeof(l1[1])
l1[[1]]
typeof(l1[[1]])
l1[['a']]

# data frame
# find and test data frame code
df = read.table('NHanes.txt',header=TRUE, row.names = 1, sep='\t')
des(df)
head(df)
# access values of df
df[1,1] # consider as matrix
df$Age[1] # by variable name
df['83732',] # by row name
# create new variable based on existing ones
df$BMI = round(df$BMXWT / (df$BMXHT/100)^2,1)
# recoding variables:
df$bpcat[df$Sy_blood>140] <- 'High BP'
df$bpcat[df$Sy_blood<=120] <- 'Normal BP'
df$bpcat[df$Sy_blood>120 & df$Sy_blood<=140] <- 'Borderline BP'

# write df to file 'NHANES
write.table(df,'NHANES.txt',row.names = FALSE,quote = FALSE,sep = '\t')
save() # save any number of objects
save.image() # ssave entire workspace
load()

# R plot function
x = rnorm(100)
y = rnorm(100)
plot(x,y,typeof)
hist(x)
boxplot(x,y)
pie(c(1,5,10))

pdf('test_figure.pdf')
plot(x,y,col='red')
dev.off()


# ggplot2
# https://ggplot2.tidyverse.org/reference/

install.packages('ggplot2', 'epiDisplay' )
library(ggplot2)
library(epiDisplay)
data(package = "epiDisplay") # show data in package
data(BP)
des(BP)	# description of data frame


# https://wwwn.cdc.gov/Nchs/Nhanes/2015-2016/DEMO_I.htm

# line plot with dual-y axes
data("economics")
p <-  ggplot(economics,aes(x = date))
p +
    geom_line(aes(y = unemploy, color = 'Unemployment number'),size = 1.5,linetype = 2) +
    # match the scale of unemployment with total population
    geom_line(aes(y = uempmed*609, color = 'Unemployment duration'),size = 1.5) +
    # /20 to transform unemployment to its true scale
    scale_y_continuous(sec.axis = sec_axis(~./609, name = 'Unemployment duration in weeks')) +
    scale_color_manual(values = c('blue','red'))+
    labs(y = "Unemployment number in thousands",
         x = "Date",
         color = 'Numbers')


# histogram
g <- ggplot(df,aes(Age)) + scale_fill_brewer(palette = 'Spectral') # to show all palettes: display.brewer.all()
# the one with wrong order
g + geom_histogram(aes(fill=factor(df$bpcat)),
                   bins=20,
                   col="black",
                   size=.1)
# set order of bpcat levels
df$bp_newcat <- factor(df$bpcat,levels = c('High BP','Borderline BP','Normal BP'), labels = c('High BP','Borderline BP','Normal BP'))
# the one with correct categorical order
g + geom_histogram(aes(fill=factor(df$bp_newcat)),
                    bins=20,
                    col="black",
					size=.1) +
					labs(title = 'Blood pressure by age in years', fill = 'BP groups') +
					theme_classic() +
					theme(plot.title = element_text(hjust = 0.5))
					

# stacked bar plot
g <- ggplot(df,aes(Race)) + scale_fill_brewer(palette = 'Spectral')
g + geom_bar(aes(fill=factor(df$bp_newcat)),
                    #bins=20,
                    col="black",
					size=.1) +
					labs(title = 'Blood pressure by race', fill = 'BP groups') +
					theme_classic() +
					theme(plot.title = element_text(hjust = 0.5))
					
# pie chart
pie_df <- data.frame(Count = as.vector(table(df$Race)),
                     Race = names(table(df$Race)))
# pie with ggplot
ggplot(pie_df, aes(x = '', y = Count, fill = Race))+
 	geom_bar(stat="identity", width=1) +
 	coord_polar("y", start=0) +
 	geom_text(aes(label = paste0(round(Count/sum(Count),2)*100,'%')), position = position_stack(vjust = 0.5)) +
 	theme_classic() +
 	theme(axis.line = element_blank(),
          axis.text = element_blank(),
          axis.ticks = element_blank(),
          plot.title = element_text(hjust = 0.5, color = "#666666"))
# pie with R base plot
pie_df$pct <- round(pie_df$Count/sum(pie_df$Count),2)
pie_lbs <- paste0(pie_df$Race,'\n',pie_df$pct,'%')
pie(pie_df$Count,labels = pie_lbs, col = rainbow(5),main = 'Percent of races in the data set')

# scatter plot
# scatter plot label highest TC & color label gender and fir regression line
ggplot(df, aes(x=BMI, y=TC, color = Gender)) +
    geom_point(alpha = 0.3,shape = 1) +
    #geom_label(data=subset(df, TC == max(TC)),aes(label=paste0('Age =', Age)),nudge_x = -5, show.legend = FALSE)+
    geom_smooth(method = 'lm', size = 1.5, se = FALSE, show.legend = FALSE) +
    scale_color_manual(values = c('tomato3','black'))+
    labs(title = 'Correlation between BMI and TC by gender',
    	x = 'BMI kg/m^2',
    	y = 'Total cholesterol mg/dL') +
	#scale_fill_brewer(palette = 'Spectral') +
    geom_hline(aes(yintercept = 240),linetype = 2, color = 'grey', size = 1) +
	theme_classic() +
	theme(plot.title = element_text(hjust = 0.5))
    # suggested TC <= 200

# heatmap
library(reshape2)
corr <- cor(df[,c(2,4:9)])
colnames(corr) <- heat_labels
rownames(corr) <- heat_labels
corr_df = melt(corr)
heat_labels <- c('Age','Weight','Height','Arm circumference','Total cholesterol','Sys BP','Dia BP')
ggplot(data = corr_df, aes(x=Var1, y=Var2, fill=value)) +
    geom_tile()+
	theme(plot.title = element_text(hjust = 0.5),
		  axis.title.x = element_blank(),
		  axis.title.y = element_blank(),
		  axis.text.x = element_text(angle = 65,vjust = 0.6))+
	labs(title = 'Correlation matrix between numeric values in data set')
# corrplot
library(corrplot)
corrplot(corr)

# box plot
# theme
ggplot(df, aes(x = factor(Race), y = Sy_blood , fill = Gender)) +
    geom_boxplot(size = 1.2) +
	scale_fill_brewer(palette = 'Spectral')+
    labs(title = 'Blood pressure by age and race',
		 x = 'Race',
         y = 'Systolic blood pressure mmHg') +
	theme_classic() +
	theme(plot.title = element_text(hjust = 0.5))

	# rearrange plot sequence
	#scale_x_discrete(limits=c('Female','Male'))+

#Faceting: split a plot into a matrix of panels

ggplot(df, aes(x = BMI, y = Sy_blood,color=Race )) +
    geom_point(alpha = 0.2) +
    geom_smooth(method = 'lm') +
    facet_grid(Race~Gender, margins = TRUE, labeller = label_context) +
    labs(x = 'BMI kg/m^2',
         y = 'Systolic blood pressure in mmHg') +
    theme(strip.text.x = element_text(size = 14, face = 'bold'),
    	strip.text.y = element_text(size = 14, face = 'bold'))

gender_n <- c('F','M','All')
names(gender_n) <- c('Female','Male','(all)')
ggplot(df, aes(x = BMI, y = Sy_blood,color=Race )) +
     geom_point(alpha = 0.2) +
     geom_smooth(method = 'lm') +
     facet_grid(Race~Gender, margins = TRUE, labeller = labeller(Gender = gender_n)) +
     labs(x = 'BMI kg/m^2',
          y = 'Systolic blood pressure in mmHg') +
    theme(strip.text.x = element_text(size = 12, face = 'bold'),
     	strip.text.y = element_text(size = 12, face = 'bold'))



