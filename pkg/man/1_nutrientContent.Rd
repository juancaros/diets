\name{nutrientContent}

\alias{nutrientContent}
\alias{fortify}


\title{
(Micro-) nutrients in food or food groups.
}

\description{
This function returns a \code{data.frame} with (micro-)nutrient content by food group. It was computed with a the USDA "Standard" Food Composition Table (FCT) by averaging the nutrients in individual food items by food group.

\code{code} = food group code

\code{group} = food group name

\code{tag} = INFOOD Food Component Identifier

\code{value} = amount of the (micro-) nutrient

\code{unit} = unit of \code{value}

\code{desc} = description of the (micro-) nutrient
}

\usage{
nutrientContent(continent="", redpalmoil=0.5, orangesweetpot=0)
}

\arguments{
  \item{continent}{character. One of "Africa", "Americas", "Asia", "Europe", "Oceania", or "". If not "", continental level adjustments are made to the fruits and vegetables composition of food groups}
  \item{redpalmoil}{numeric. Value between 0 and 1 to indicate the ratio of red palm oil}
  \item{orangesweetpot}{numeric. Value between 0 and 1 to indicate the ratio of orange sweet potatoes}
}

\value{
data.frame
}

\references{
US Department of Agriculture, Agricultural Research Service. 2016. Nutrient Data Laboratory. USDA National Nutrient Database for Standard Reference, Release 28 (Slightly revised). Version Current: May 2016. http://www.ars.usda.gov/nea/bhnrc/mafcl

Food and Agriculture Organisation (FAO) (2012) West African Food Composition Table. Rome.

University of California at Berkeley International Minilist. WorldFood Dietary Assessment System, 2nd edition.
}

\examples{

content <- nutrientContent(continent="Africa", redpalmoil=0.5, orangesweetpot=0.2)
head(content)

unique(content$tag)
table(content$unit)

# this is the table that is used to do the continent based adjustments
FCTcnt <- readRDS(system.file("ex/ContiConsump.rds", package="diets"))


# fortify
fort <- readRDS(system.file("ex/fortification.rds", package="diets"))
fort_sen <- fort[fort$area == "Senegal", ]
fort_sen

fcontent <- fortify(content, fort_sen)

# see the change
content[content$group=="Wheat and products" & content$tag=="ZN", ]
fort_sen[fort_sen$group=="Wheat and products" & fort_sen$tag=="ZN", ]
fcontent[fcontent$group=="Wheat and products" & fcontent$tag=="ZN", ]
}

