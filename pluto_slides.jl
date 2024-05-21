### A Pluto.jl notebook ###
# v0.19.41

using Markdown
using InteractiveUtils

# ╔═╡ 2210f32d-829e-4efe-a072-d478fcc18488
begin
    using PlutoLinks, PlutoHooks
    using LaTeXStrings, HypertextLiteral, TOML
	using Markdown
end

# ╔═╡ e18ba3dd-013f-4a1e-abe7-9ff9c4d61e68
md"""
# Pluto Slides
* It is a good idea to have only one "required" argument for all these functions. We can read the rest of the parameters from the TOML file (`parameters.toml`). By doing so, we can make the slides faster. 
---
"""

# ╔═╡ 09d21ffa-00d1-4f87-901d-b6c9aee0c954
"""
Function for title slide with a background image.

# Arguments

* `title` : Title of the presentation
* `author` : Name of the authors
* `affiliations` : Affiliations of the authors 
* `contitle` : Title of the conference if any
* `background_image`: url of the background image (currently local images are not supported)
"""
function titleslidebi(title,author,affiliations,contitle,background_image="")
	slide=
		@htl("""
<style>
	    main {
        max-width: 1700px;
    }
    .titlesl {
        width: 1600px;
        height: 900px;
        margin: auto;
        padding: 0px;
        box-sizing: border-box;
        position: relative;
  		background-image: url('$background_image'); /* Path to your background image */
		background-size: 100% 100%;
		background-position: 55% 50%;
		background-repeat: no-repeat; /* Prevent background image from repeating */
    }
		.title-box1 {
	position: absolute
    padding: 5px 10px; /* Adjust padding as needed */
    background-color: #3333B2; /* Adjust background color as needed */
    color: white; /* Adjust text color as needed */
    border-radius: 50px; /* Adjust border radius as needed */
    font-size: 60px; /* Adjust font size as needed */
	text-align: center;
}
	.content2{
		max-height: 680px;
        overflow: hidden;
		margin-bottom: 2px;
		color: #E3E552;
		padding: 10px 10px;
		text-align: justify;
        box-sizing: border-box;
	}
	.slide-box1 {
	position: absolute;
	width: 100%;
	bottom: 0px;
	height: 20px;
	margin-left: -10px;
    padding: 0px 0px; /* Adjust padding as needed */
    background-color: #3333B2; /* Adjust background color as needed */
    color: #fff; /* Adjust text color as needed */
    border-radius: 0px; /* Adjust border radius as needed */
    font-size: 24px; /* Adjust font size as needed */
}
</style>
<div class="titlesl">
	<h1></h1>	
	<div class="title-box1">
	<div style="font-size: 42px; margin-top: 10px;text-align: center;">
	$title
	</div>
	</div>
	<div class="content2">
	<div align="center;" style="font-size: 36px; margin-top: 150px;text-align: center;">
	$author
	</div>
	<div align="center;" style="font-size: 32px; margin-top: 50px;text-align: center;">
	$affiliations
	</div>
	<div align="center;" style="font-size: 36px; margin-top: 100px;text-align: center;">
	$contitle
	</div>
	<div class="slide-box1">
	<div style="display: flex; font-size: 24px;"><div style="flex: 33%;margin-right: 1px;text-align: left;">
	</div>
	</div>
""")
	return slide
end

# ╔═╡ c42fc7aa-6254-4342-8b5c-a24b67924fde
"""
Function for title slide without a background image.

# Arguments

* `title` : Title of the presentation
* `author` : Name of the authors
* `affiliations` : Affiliations of the authors 
* `contitle` : Title of the conference if any
"""
function titleslide(title,author,affiliations,contitle)
	slide=
		@htl("""
<style>
	    main {
        max-width: 1700px;
    }
    .titlesl1 {
        width: 1600px;
        height: 900px;
        margin: auto;
        padding: 0px;
        box-sizing: border-box;
        position: relative;
    }
		.title-box2 {
	position: absolute
    padding: 5px 10px; /* Adjust padding as needed */
    background-color: #3333B2; /* Adjust background color as needed */
    color: white; /* Adjust text color as needed */
    border-radius: 50px; /* Adjust border radius as needed */
    font-size: 60px; /* Adjust font size as needed */
	text-align: center;
}
	.content3{
		max-height: 680px;
        overflow: hidden;
		margin-bottom: 2px;
		color: black;
		padding: 10px 10px;
		text-align: justify;
        box-sizing: border-box;
	}
	.slide-box {
	position: absolute;
	width: 100%;
	bottom: 30px;
    padding: 5px 10px; /* Adjust padding as needed */
    background-color: #3333B2; /* Adjust background color as needed */
    color: #fff; /* Adjust text color as needed */
    border-radius: 10px; /* Adjust border radius as needed */
    font-size: 24px; /* Adjust font size as needed */
}
</style>
<div class="titlesl1">
		<h1></h1>
	<div class="title-box2">
	<div style="font-size: 42px; margin-top: 10px;text-align: center;">
	$title
	</div>
	</div>
	<div class="content3">
	<div align="center;" style="font-size: 36px; margin-top: 100px;text-align: center;">
	$author
	</div>
	<div align="center;" style="font-size: 32px; margin-top: 50px;text-align: center;">
	$affiliations
	</div>
	<div align="center;" style="font-size: 36px; margin-top: 100px;text-align: center;">
	$contitle
	</div>
		    <div class="slide-box">
	</div>
""")
	return slide
end

# ╔═╡ c1f832df-8184-4fe2-bfb3-7ab6f007b19b
begin
	references="sa"
@htl("""
if ($references == "") {
<div>	
empty
	</div>
}
""")
end

# ╔═╡ b3288414-b4aa-4352-8a3e-a387d55d18a6
"""
2x2 layout of a slide for texts and images. The text should be written using markdown.
# Arguments

* `title` : Title of the slide
* `content_vec` : Vector of size 4 with texts as markdowns and images as PlutoUI.LocalResources
* `references` : References for current slide if nay 
* `slide_number` : Number of the slide 
* `author`: Name of the authors
"""
function slide2x2(title,content_vec, references,slide_number,section="Theory",author="Sanket Bajad";spacing="auto")
    slide = @htl("""
<style>
	    main {
        max-width: 1700px;
    }
    .slide2 {
        width: 1600px;
        height: 900px;
        margin: auto;
        padding: 0px;
        box-sizing: border-box;
        position: relative;
    }
	.title {
    font-size: 42px;
}
	.content{
		max-height: 680px;
        overflow: hidden;
		margin-bottom: 2px;
		background-color: white;
		color: black;
		font-size: 30px;
		padding: 10px 10px;
		text-align: justify;
        box-sizing: border-box;
	}
.references {
		position: absolute;
		width: 100%;
		bottom: 50px;
        font-size: 24px;
        font-style: italic;
        text-align: left;
		margin-bottom: 5px;
		background-color: #FEFCF5;
		border-radius: 10px; 
		color: black;
		padding: 4px 4px;
		text-align: justify;
	 	border: 1px solid #9EC889;
        box-sizing: border-box;
    }
	.slide-number-box {
	position: absolute;
	width: 100%;
	bottom: 0px;
    padding: 5px 10px; /* Adjust padding as needed */
    background-color: #3333B2; /* Adjust background color as needed */
    color: #fff; /* Adjust text color as needed */
    border-radius: 10px; /* Adjust border radius as needed */
    font-size: 24px; /* Adjust font size as needed */
}
	.title-box {
	margin-top: 10px;
    padding: 5px 10px; /* Adjust padding as needed */
    background-color: #3333B2; /* Adjust background color as needed */
    color: white; /* Adjust text color as needed */
    border-radius: 10px; /* Adjust border radius as needed */
    font-size: 42px; /* Adjust font size as needed */
}
.container {
    box-sizing: border-box;
    border: 0px solid #000; /* Add borders for visualization */
    padding: 10px; /* Add padding as needed */
    flex: 1 1 auto; /* Each container takes its content's size, with the ability to shrink or grow */
}
</style>
	
    <div class="slide2">
    <h1 class="title-box">
	<div align="center;margin-top: 1px;">
	$title
	</div>
	</h1>
	<div class="content">
<div class="container">
	<div style="display: flex;"><div style="flex: $(spacing);flex-wrap: wrap;">
        $(content_vec[1])
		$(content_vec[2])
	</div>
	<div style="display: flex;"><div style="flex: $(spacing);flex-wrap: wrap;">
        $(content_vec[3])
		$(content_vec[4])
	</div>
</div>
</div>
	<div class="references">
    <div align="center;" style="display: slide;font-style: italic;text-align: left;">
		$references
    </div>
	</div>
	    <div class="slide-number-box">
	<div style="display: flex; font-size: 24px;"><div style="flex: 33%;margin-right: 1px;text-align: left;">
            $author
    </div>
	<div style="flex: 33%;font-size: 24px;margin-left: 1px;margin-right: 1px;text-align: center;">
	$section
	</div>
	<div style="flex: 33%;font-size: 24px;margin-left: 1px;text-align: right;">
	$slide_number
	</div>
</div>
</div>
</div>
""")
    return slide
end

# ╔═╡ 884215ac-bfd0-4979-830c-1a4709bd723d
"""
2x2 layout of a slide only for images.
# Arguments

* `title` : Title of the slide
* `content_vec` : Vector of size 4 with images as PlutoUI.LocalResources
* `references` : References for current slide if nay 
* `slide_number` : Number of the slide 
* `author`: Name of the authors
"""
function slide2x2Images(title,content_vec, references,slide_number,section="Theory",author="Sanket Bajad")
    slide = @htl("""
<style>
	    main {
        max-width: 1700px;
    }
    .slide2 {
        width: 1600px;
        height: 900px;
        margin: auto;
        padding: 0px;
        box-sizing: border-box;
        position: relative;
    }
	.title {
    font-size: 42px;
}
	.content{
		max-height: 680px;
        overflow: hidden;
		margin-bottom: 2px;
		background-color: white;
		color: black;
		padding: 10px 10px;
		text-align: justify;
        box-sizing: border-box;
	}
.references {
		position: absolute;
		width: 100%;
		bottom: 50px;
        font-size: 24px;
        font-style: italic;
        text-align: left;
		margin-bottom: 5px;
		background-color: #FEFCF5;
		border-radius: 10px; 
		color: black;
		padding: 4px 4px;
		text-align: justify;
	 	border: 1px solid #9EC889;
        box-sizing: border-box;
    }
	.slide-number-box {
	position: absolute;
	width: 100%;
	bottom: 0px;
    padding: 5px 10px; /* Adjust padding as needed */
    background-color: #3333B2; /* Adjust background color as needed */
    color: #fff; /* Adjust text color as needed */
    border-radius: 10px; /* Adjust border radius as needed */
    font-size: 24px; /* Adjust font size as needed */
}
	.title-box {
	margin-top: 10px;
    padding: 5px 10px; /* Adjust padding as needed */
    background-color: #3333B2; /* Adjust background color as needed */
    color: white; /* Adjust text color as needed */
    border-radius: 10px; /* Adjust border radius as needed */
    font-size: 42px; /* Adjust font size as needed */
}
.content-block {
        width: 50%; /* Each block occupies half the width */
        height: 50%; /* Each block occupies half the height */
        box-sizing: border-box;
        padding: 10px; /* Adjust padding as needed */
        border: 0px solid #000; /* Add borders for better visualization */
    }
	.grid-container {
  display: grid;
  grid-template-columns: auto auto;
  padding: 10px;
}
.grid-item {
  padding: 2px;
  text-align: center;
}
</style>
	
    <div class="slide2">
    <h1 class="title-box">
	<div align="center;margin-top: 1px;">
	$title
	</div>
	</h1>
	<div class="content">
<div class="grid-container">
  <div class="grid-item">$(content_vec[1])</div>
  <div class="grid-item">$(content_vec[2])</div>
  <div class="grid-item">$(content_vec[3])</div>  
  <div class="grid-item">$(content_vec[4])</div>  
</div>
</div>
	<div class="references">
    <div align="center;" style="display: slide;font-style: italic;text-align: left;">
		$references
    </div>
	</div>
	    <div class="slide-number-box">
	<div style="display: flex; font-size: 24px;"><div style="flex: 33%;margin-right: 1px;text-align: left;">
            $author
    </div>
	<div style="flex: 33%;font-size: 24px;margin-left: 1px;margin-right: 1px;text-align: center;">
	$section
	</div>
	<div style="flex: 33%;font-size: 24px;margin-left: 1px;text-align: right;">
	$slide_number
	</div>
</div>
</div>
</div>
""")
    return slide
end

# ╔═╡ 23328af9-c7ed-4228-b8ab-7d3542a48467
"""
Slide with single column layout.
# Arguments

* `title` : Title of the slide
* `content` : slide content as markdown texts or images using PlutoUI.LocalResources
* `references` : References for current slide if nay 
* `slide_number` : Number of the slide
* `section` : Title of the section
* `author`: Name of the authors
"""
function onecolslide(title, content, references,slide_number,section="Theory";author="Sanket Bajad",algn="justify")
if (references !="")
    slide = @htl("""
<style>
	    main {
        max-width: 1700px;
    }
    .slide {
        width: 1600px;
        height: 900px;
        margin: auto;
        padding: 0px;
        box-sizing: border-box;
        position: relative;
    }
	.title {
    font-size: 42px;
}
	.content{
		max-height: 680px;
        overflow: hidden;
		margin-bottom: 2px;
		background-color: white;
		color: black;
		padding: 10px 10px;
		text-align: $(algn);
        box-sizing: border-box;
	}
.references {
		position: absolute;
		width: 100%;
		bottom: 50px;
        font-size: 24px;
        font-style: italic;
        text-align: left;
		margin-bottom: 5px;
		background-color: #FEFCF5;
		border-radius: 10px; 
		color: black;
		padding: 4px 4px;
		text-align: justify;
	 	border: 1px solid #9EC889;
        box-sizing: border-box;
    }
	.slide-number-box {
	position: absolute;
	width: 100%;
	bottom: 0px;
    padding: 5px 10px; /* Adjust padding as needed */
    background-color: #3333B2; /* Adjust background color as needed */
    color: #fff; /* Adjust text color as needed */
    border-radius: 10px; /* Adjust border radius as needed */
    font-size: 24px; /* Adjust font size as needed */
}
	.title-box {
	margin-top: 10px;
    padding: 5px 10px; /* Adjust padding as needed */
    background-color: #3333B2; /* Adjust background color as needed */
    color: white; /* Adjust text color as needed */
    border-radius: 10px; /* Adjust border radius as needed */
    font-size: 42px; /* Adjust font size as needed */
}
</style>
    <div class="slide">
        <h1 class="title-box">
	<div align="center;margin-top: 1px;">
	$title
	</h1>
        <div class="content">
		<div align="$(algn);" style="font-size: 30px;">
            $content
        </div>
	</div>
	<div class="references">
    <div align="center;" style="display: slide;font-style: italic;text-align: left;">
		$references
    </div>
	</div>
	    <div class="slide-number-box">
	<div style="display: flex; font-size: 24px;"><div style="flex: 33%;margin-right: 1px;text-align: left;">
            $author
    </div>
	<div style="flex: 33%;font-size: 24px;margin-left: 1px;margin-right: 1px;text-align: center;">
	$section
	</div>
	<div style="flex: 33%;font-size: 24px;margin-left: 1px;text-align: right;">
	$slide_number
	</div>
</div>
</div>
</div>
""")
else
    slide = @htl("""
<style>
	    main {
        max-width: 1700px;
    }
    .slide {
        width: 1600px;
        height: 900px;
        margin: auto;
        padding: 0px;
        box-sizing: border-box;
        position: relative;
    }
	.title {
    font-size: 42px;
}
	.content{
		max-height: 680px;
        overflow: hidden;
		margin-bottom: 2px;
		background-color: white;
		color: black;
		padding: 10px 10px;
		text-align: $(algn);
        box-sizing: border-box;
	}
.references {
		position: absolute;
		width: 100%;
		bottom: 50px;
        font-size: 24px;
        font-style: italic;
        text-align: left;
		margin-bottom: 5px;
		background-color: #FEFCF5;
		border-radius: 10px; 
		color: black;
		padding: 4px 4px;
		text-align: justify;
	 	border: 1px solid #9EC889;
        box-sizing: border-box;
    }
	.slide-number-box {
	position: absolute;
	width: 100%;
	bottom: 0px;
    padding: 5px 10px; /* Adjust padding as needed */
    background-color: #3333B2; /* Adjust background color as needed */
    color: #fff; /* Adjust text color as needed */
    border-radius: 10px; /* Adjust border radius as needed */
    font-size: 24px; /* Adjust font size as needed */
}
	.title-box {
	margin-top: 10px;
    padding: 5px 10px; /* Adjust padding as needed */
    background-color: #3333B2; /* Adjust background color as needed */
    color: white; /* Adjust text color as needed */
    border-radius: 10px; /* Adjust border radius as needed */
    font-size: 42px; /* Adjust font size as needed */
}
</style>
    <div class="slide">
        <h1 class="title-box">
	<div align="center;margin-top: 1px;">
	$title
	</h1>
        <div class="content">
		<div align="$(algn);" style="font-size: 30px;">
            $content
        </div>
	</div>
	    <div class="slide-number-box">
	<div style="display: flex; font-size: 24px;"><div style="flex: 33%;margin-right: 1px;text-align: left;">
            $author
    </div>
	<div style="flex: 33%;font-size: 24px;margin-left: 1px;margin-right: 1px;text-align: center;">
	$section
	</div>
	<div style="flex: 33%;font-size: 24px;margin-left: 1px;text-align: right;">
	$slide_number
	</div>
</div>
</div>
</div>
""")
end
    return slide
end


# ╔═╡ 7650a135-684d-4d9b-8d8e-5a0b28c08398
"""
Slide with two columns layout.
# Arguments

* `title` : Title of the slide
* `content_vec` : vector of size 2 with slide content as markdown texts or images using PlutoUI.LocalResources
* `references` : References for current slide if nay 
* `slide_number` : Number of the slide
* `section` : Title of the section
* `author`: Name of the authors
"""
function twocolslide(title,content_vec, references,slide_number,section="Theory";author="Sanket Bajad",algn=["justify","justify"],spacing="auto")
if (references != "")
    slide = @htl("""
<style>
	    main {
        max-width: 1700px;
    }
    .slide {
        width: 1600px;
        height: 900px;
        margin: auto;
        padding: 0px;
        box-sizing: border-box;
        position: relative;
    }
	.title {
    font-size: 42px;
}
	.content{
		max-height: 680px;
        overflow: hidden;
		margin-bottom: 2px;
		background-color: white;
		color: black;
		padding: 10px 10px;
		text-align: justify;
        box-sizing: border-box;
	}
.references {
		position: absolute;
		width: 100%;
		bottom: 50px;
        font-size: 24px;
        font-style: italic;
        text-align: left;
		margin-bottom: 5px;
		background-color: #FEFCF5;
		border-radius: 10px; 
		color: black;
		padding: 4px 4px;
		text-align: justify;
	 	border: 1px solid #9EC889;
        box-sizing: border-box;
    }
	.slide-number-box {
	position: absolute;
	width: 100%;
	bottom: 0px;
    padding: 5px 10px; /* Adjust padding as needed */
    background-color: #3333B2; /* Adjust background color as needed */
    color: #fff; /* Adjust text color as needed */
    border-radius: 10px; /* Adjust border radius as needed */
    font-size: 24px; /* Adjust font size as needed */
}
	.title-box {
	margin-top: 10px;
    padding: 5px 10px; /* Adjust padding as needed */
    background-color: #3333B2; /* Adjust background color as needed */
    color: white; /* Adjust text color as needed */
    border-radius: 10px; /* Adjust border radius as needed */
    font-size: 42px; /* Adjust font size as needed */
}
</style>
    <div class="slide">
        <h1 class="title-box">
	<div align="center;margin-top: 1px;">
	$title
	</h1>
        <div class="content">
	  <div style="display: flex; font-size: 30px;"><div style="flex: $(spacing); margin-right: 5px; text-align:$(algn[1]);">
        $(content_vec[1])
    </div>
    <div style="flex: $(spacing); margin-left: 5px; text-align: $(algn[2]);">
        $(content_vec[2])
    </div>
	</div>
	<div class="references">
    <div align="center;" style="display: slide;font-style: italic;text-align: left;">
		$references
    </div>
	</div>
	    <div class="slide-number-box">
	<div style="display: flex; font-size: 24px;"><div style="flex: 33%;margin-right: 1px;text-align: left;">
            $author
    </div>
	<div style="flex: 33%;font-size: 24px;margin-left: 1px;margin-right: 1px;text-align: center;">
	$section
	</div>
	<div style="flex: 33%;font-size: 24px;margin-left: 1px;text-align: right;">
	$slide_number
	</div>
</div>
</div>
</div>
""")
else
   slide = @htl("""
<style>
	    main {
        max-width: 1700px;
    }
    .slide {
        width: 1600px;
        height: 900px;
        margin: auto;
        padding: 0px;
        box-sizing: border-box;
        position: relative;
    }
	.title {
    font-size: 42px;
}
	.content{
		max-height: 680px;
        overflow: hidden;
		margin-bottom: 2px;
		background-color: white;
		color: black;
		padding: 10px 10px;
		text-align: justify;
        box-sizing: border-box;
	}
.references {
		position: absolute;
		width: 100%;
		bottom: 50px;
        font-size: 24px;
        font-style: italic;
        text-align: left;
		margin-bottom: 5px;
		background-color: #FEFCF5;
		border-radius: 10px; 
		color: black;
		padding: 4px 4px;
		text-align: justify;
	 	border: 1px solid #9EC889;
        box-sizing: border-box;
    }
	.slide-number-box {
	position: absolute;
	width: 100%;
	bottom: 0px;
    padding: 5px 10px; /* Adjust padding as needed */
    background-color: #3333B2; /* Adjust background color as needed */
    color: #fff; /* Adjust text color as needed */
    border-radius: 10px; /* Adjust border radius as needed */
    font-size: 24px; /* Adjust font size as needed */
}
	.title-box {
	margin-top: 10px;
    padding: 5px 10px; /* Adjust padding as needed */
    background-color: #3333B2; /* Adjust background color as needed */
    color: white; /* Adjust text color as needed */
    border-radius: 10px; /* Adjust border radius as needed */
    font-size: 42px; /* Adjust font size as needed */
}
</style>
    <div class="slide">
        <h1 class="title-box">
	<div align="center;margin-top: 1px;">
	$title
	</h1>
        <div class="content">
	  <div style="display: flex; font-size: 30px;"><div style="flex: $(spacing); margin-right: 5px; text-align:$(algn[1]);">
        $(content_vec[1])
    </div>
    <div style="flex: $(spacing); margin-left: 5px; text-align: $(algn[2]);">
        $(content_vec[2])
    </div>
	</div>
	    <div class="slide-number-box">
	<div style="display: flex; font-size: 24px;"><div style="flex: 33%;margin-right: 1px;text-align: left;">
            $author
    </div>
	<div style="flex: 33%;font-size: 24px;margin-left: 1px;margin-right: 1px;text-align: center;">
	$section
	</div>
	<div style="flex: 33%;font-size: 24px;margin-left: 1px;text-align: right;">
	$slide_number
	</div>
</div>
</div>
</div>
""")
end	
    return slide
end

# ╔═╡ e800fdff-a9f1-46ca-b85d-90ddf983db13
"""
Slide with three columns layout.
# Arguments

* `title` : Title of the slide
* `content_vec` : vector of size 3 with slide content as markdown texts or images using PlutoUI.LocalResources
* `references` : References for current slide if nay 
* `slide_number` : Number of the slide
* `section` : Title of the section
* `author`: Name of the authors
"""
function threecolslide(title, content_vec, references,slide_number,section="Theory",author="Sanket Bajad")
    slide = @htl("""
<style>
	    main {
        max-width: 1700px;
    }
    .slide {
        width: 1600px;
        height: 900px;
        margin: auto;
        padding: 0px;
        box-sizing: border-box;
        position: relative;
    }
	.title {
    font-size: 42px;
}
	.content{
		max-height: 680px;
        overflow: hidden;
		margin-bottom: 2px;
		background-color: white;
		color: black;
		padding: 10px 10px;
		text-align: justify;
        box-sizing: border-box;
	}
.references {
		position: absolute;
		width: 100%;
		bottom: 50px;
        font-size: 24px;
        font-style: italic;
        text-align: left;
		margin-bottom: 5px;
		background-color: #FEFCF5;
		border-radius: 10px; 
		color: black;
		padding: 4px 4px;
		text-align: justify;
	 	border: 1px solid #9EC889;
        box-sizing: border-box;
    }
	.slide-number-box {
	position: absolute;
	width: 100%;
	bottom: 0px;
    padding: 5px 10px; /* Adjust padding as needed */
    background-color: #3333B2; /* Adjust background color as needed */
    color: #fff; /* Adjust text color as needed */
    border-radius: 10px; /* Adjust border radius as needed */
    font-size: 24px; /* Adjust font size as needed */
}
	.title-box {
	margin-top: 10px;
    padding: 5px 10px; /* Adjust padding as needed */
    background-color: #3333B2; /* Adjust background color as needed */
    color: white; /* Adjust text color as needed */
    border-radius: 10px; /* Adjust border radius as needed */
    font-size: 42px; /* Adjust font size as needed */
}
</style>
    <div class="slide">
        <h1 class="title-box">
	<div align="center;margin-top: 1px;">
	$title
	</h1>
        <div class="content">
	  <div style="display: flex; font-size: 32px;"><div style="flex: auto; margin-right: 10px; text-align: justify;">
        $(content_vec[1])
    </div>
    <div style="flex: auto; margin-left: 10px; text-align: justify;">
        $(content_vec[2])
    </div>
	<div style="flex: auto; margin-left: 10px; text-align: justify;">
        $(content_vec[3])
    </div>
	</div>
	<div class="references">
    <div align="center;" style="display: slide;font-style: italic;text-align: left;">
		$references
    </div>
	</div>
	    <div class="slide-number-box">
	<div style="display: flex; font-size: 24px;"><div style="flex: 33%;margin-right: 1px;text-align: left;">
            $author
    </div>
	<div style="flex: 33%;font-size: 24px;margin-left: 1px;margin-right: 1px;text-align: center;">
	$section
	</div>
	<div style="flex: 33%;font-size: 24px;margin-left: 1px;text-align: right;">
	$slide_number
	</div>
</div>
</div>
</div>
""")
    return slide
end

# ╔═╡ 6c18c41f-ee57-4fb1-8499-f7e4b89c1a3c
"""
Function to hide cells.
"""
function hide_everything_below()
	hide_everything_below =
	html"""
	<style>
	pluto-cell.hide_everything_below ~ pluto-cell {
		display: none;
	}
	</style>
	
	<script>
	const cell = currentScript.closest("pluto-cell")
	
	const setclass = () => {
		console.log("change!")
		cell.classList.toggle("hide_everything_below", true)
	}
	setclass()
	const observer = new MutationObserver(setclass)
	
	observer.observe(cell, {
		subtree: false,
		attributeFilter: ["class"],
	})
	
	invalidation.then(() => {
		observer.disconnect()
		cell.classList.toggle("hide_everything_below", false)
	})
	
	</script>
	"""
end

# ╔═╡ c5e687ed-89c2-4267-8c01-bdf603721c27
md"## Admonition"

# ╔═╡ 981ff634-c20b-46d5-9c0a-2bf6fec0af91
function admon(content, title="", color=:blue)
	colors=Dict([:blue => "info", :yellow=> "warning", :red => "danger", :green => "warn"])
	Markdown.MD(Markdown.Admonition(colors[color], title, [content]))
end

# ╔═╡ 0bbc0291-7415-40dc-b6f1-2521c8cc356c
parameters = TOML.parsefile(joinpath(@__DIR__, "parameters.toml"))

# ╔═╡ 1f9175e4-c07d-499c-9db9-188e557aa260
TableOfContents(include_definitions=true)

# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
Einsum = "b7d42ee7-0b51-5a75-98ca-779d3107e4c0"
FFTW = "7a1cc6ca-52ef-59f5-83cd-3a7055c09341"
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
Images = "916415d5-f1e6-5110-898d-aaa5f9f070e0"
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
Markdown = "d6f4376e-aef5-505a-96c1-9c027394607a"
PlutoHooks = "0ff47ea0-7a50-410d-8455-4348d5de0774"
PlutoLinks = "0ff47ea0-7a50-410d-8455-4348d5de0420"
TOML = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[compat]
Einsum = "~0.4.1"
FFTW = "~1.7.2"
HypertextLiteral = "~0.9.5"
Images = "~0.26.0"
LaTeXStrings = "~1.3.1"
PlutoHooks = "~0.0.5"
PlutoLinks = "~0.1.6"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
"""

# ╔═╡ Cell order:
# ╟─e18ba3dd-013f-4a1e-abe7-9ff9c4d61e68
# ╠═09d21ffa-00d1-4f87-901d-b6c9aee0c954
# ╠═c42fc7aa-6254-4342-8b5c-a24b67924fde
# ╠═c1f832df-8184-4fe2-bfb3-7ab6f007b19b
# ╠═b3288414-b4aa-4352-8a3e-a387d55d18a6
# ╠═884215ac-bfd0-4979-830c-1a4709bd723d
# ╠═23328af9-c7ed-4228-b8ab-7d3542a48467
# ╠═7650a135-684d-4d9b-8d8e-5a0b28c08398
# ╠═e800fdff-a9f1-46ca-b85d-90ddf983db13
# ╠═6c18c41f-ee57-4fb1-8499-f7e4b89c1a3c
# ╠═c5e687ed-89c2-4267-8c01-bdf603721c27
# ╠═981ff634-c20b-46d5-9c0a-2bf6fec0af91
# ╠═2210f32d-829e-4efe-a072-d478fcc18488
# ╠═0bbc0291-7415-40dc-b6f1-2521c8cc356c
# ╠═1f9175e4-c07d-499c-9db9-188e557aa260
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
