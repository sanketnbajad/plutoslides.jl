### A Pluto.jl notebook ###
# v0.20.0

using Markdown
using InteractiveUtils

# ╔═╡ 2210f32d-829e-4efe-a072-d478fcc18488
begin
    using PlutoLinks, PlutoHooks, PlutoUI
    using LaTeXStrings, TOML
    using Markdown
	using HypertextLiteral: @htl
end

# ╔═╡ e18ba3dd-013f-4a1e-abe7-9ff9c4d61e68
md"""
# Pluto Slides
* It is a good idea to have only one "required" argument for all these functions. We can read the rest of the parameters from the TOML file (`parameters.toml`). By doing so, we can make the slides faster.
* Use keyword arguments for all functions other than content.
---
"""

# ╔═╡ 8907ddc3-09b3-4983-8c45-4c431ef31a7f
0.9*1800

# ╔═╡ cb68d0e3-1c63-4141-812a-566e05e95c25


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

# ╔═╡ 230aef68-badf-4002-bfcf-e83b8c192a80
begin
    references = "sa"
    @htl("""
    if ($references == "") {
    <div>	
    empty
    	</div>
    }
    """)
end

# ╔═╡ 981ff634-c20b-46d5-9c0a-2bf6fec0af91
"""
	admon(content, title="", color=:blue)

Create an admonition block with the specified content, title, and color.

# Arguments
- `content`: The content of the admonition block.
- `title`: The title of the admonition block (default: "").
- `color`: The color of the admonition block (default: :blue).

# Returns
An `Admonition` object representing the admonition block.

# Example
"""
function admon(content; title="", color=:blue)
    colors = Dict([:blue => "info", :yellow => "warning", :red => "danger", :green => "warn"])
    Markdown.MD(Markdown.Admonition(colors[color], title, [content]))
end

# ╔═╡ 0bbc0291-7415-40dc-b6f1-2521c8cc356c
parameters = TOML.parsefile(joinpath(@__DIR__, "parameters.toml"))

# ╔═╡ 44f58c83-a344-4282-ba3f-c76e09bf2f27
"""
Function for title slide with logos.

# Arguments

* `title` : Title of the presentation
* `author` : Name of the authors
* `affiliations` : Affiliations of the authors 
* `contitle` : Title of the conference if any
* `background_image`: url of the background image (currently local images are not supported, you can add the author's headshot using this)
* `left_logo`: url of the left logo (currently local images are not supported)
* `right_logo`: url of the right logo (currently local images are not supported)
* `size`: width and length of the left logo
* `size1`: width and length of the right logo
"""
function titleslidelogo(; title="Title", author=parameters["authors"], affiliations="IISc", contitle=parameters["conference"], background_image="", left_logo="", right_logo="", size=["100px", "100px"], size1=["100px", "100px"])
    slide =
        @htl("""
        <style>
            main {
                max-width: 2400px;
                margin: auto;
                display: flex;
                flex-direction: column;
                justify-content: space-between;
                align-items: center;
                box-sizing: border-box;
            }
			.slide {
        		width: 1600px;
        		height: 900px;
        		margin: auto;
        		padding: 0px;
        		box-sizing: border-box;
        		position: relative;
    			}

            .logo-container {
                display: flex;
                justify-content: space-between;
                width: 100%;
                padding: 10px;
                box-sizing: border-box;
            }

            .logo {
                max-height: 100px;
            }

            .title-box1 {
                background-color: #3333B2;
                color: white;
                border-radius: 50px;
                font-size: 3rem;
                padding: 15px 30px;
                text-align: center;
                width: 100%; /* Adjust for a centered layout */
            }

            .content2 {
                flex: 1;
                text-align: center;
                color: black;
                # padding: 20px;
                font-size: 1.5rem;
                # overflow-y: auto;
				max-height: 775px;
              overflow: hidden;
      		margin-bottom: 2px;
      		color: black;
      		padding: 10px 10px;
      		# text-align: justify;
              box-sizing: border-box;
            }
		.slide-number-box1 {
     		position: absolute;
     		width: 100%;
     		bottom: 0px;
			height=20px;
		margin-left: -10px;
         	padding: 10px; /* Adjust padding as needed */
         	background-color: #3333B2; /* Adjust background color as needed */
         	color: #fff; /* Adjust text color as needed */
         	border-radius: 10px; /* Adjust border radius as needed */
         	font-size: 24px; /* Adjust font size as needed */
     }
        </style>
        <div class="slide">
            <div class="logo-container">
                <img src="$left_logo" alt="Left Logo" class="logo" style="height: $(size[1]);" />
                <img src="$right_logo" alt="Right Logo" class="logo" style="height: $(size1[1]);" />
            </div>
            <div class="title-box1">
                $title
            </div>
            <div class="content2">
                <p>$author</p>
                <p>$affiliations</p>
                <p>$contitle</p>
            </div>
            <div class="slide-number-box1">
               <div style="display: flex; font-size: 24px;"><div style="flex: 							33%;margin-right: 1px;text-align: center;">
            </div>
        </div>
        """)
    return slide
end



# ╔═╡ f912a32d-8c46-4e3d-bde5-4893ba74b416
"""
Function for title slide with a background image.

# Arguments

* `title` : Title of the presentation
* `author` : Name of the authors
* `affiliations` : Affiliations of the authors 
* `contitle` : Title of the conference if any
* `background_image`: url of the background image (currently local images are not supported)
"""
function titleslidebi(;title="Title", author=parameters["authors"], affiliations="IISc", contitle=parameters["conference"], background_image="")
    slide =
        @htl("""
      <style>
          .titlesl {
              width: 100%;
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
      		max-height: 775px;
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

# ╔═╡ a6496eb0-3fcd-4382-805a-61625d6f4eb5
"""
Function for title slide without a background image.

# Arguments

* `title` : Title of the presentation
* `author` : Name of the authors
* `affiliations` : Affiliations of the authors 
* `contitle` : Title of the conference if any
"""
function titleslide(; title="Title", author=parameters["authors"], affiliations="IISc", contitle=parameters["conference"])
    slide =
        @htl("""
      <style>
          .titlesl1 {
              width: 100%;
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
      		max-height: 775px;
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

# ╔═╡ 4c7c8965-8b82-4706-ab31-98cb26dab635
"""
2x2 layout of a slide for texts and images. The text should be written using markdown.
# Arguments

* `title` : Title of the slide
* `content_vec` : Vector of size 4 with texts as markdowns and images as PlutoUI.LocalResources
* `references` : References for current slide if nay 
* `slide_number` : Number of the slide 
* `author`: Name of the authors
"""
function slide2x2(content_vec; title="Title", section="Theory", references="", slide_number="?", author=parameters["authors"], spacing="auto")
    slide = @htl("""
<style>
	.title {
    font-size: 42px;
}
	.content{
		max-height: 775px;
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
	
    <div class="slide">
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

# ╔═╡ 98338d28-6fca-46ef-801f-d86ed2f75205
"""
2x2 layout of a slide only for images.
# Arguments

* `title` : Title of the slide
* `content_vec` : Vector of size 4 with images as PlutoUI.LocalResources
* `references` : References for current slide if nay 
* `slide_number` : Number of the slide 
* `author`: Name of the authors
"""
function slide2x2Images(content_vec; title="Title", section="Theory", references="", slide_number="?", author=parameters["authors"])
    slide = @htl("""
<style>
	.title {
    font-size: 42px;
}
	.content{
		max-height: 775px;
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
	
    <div class="slide">
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

# ╔═╡ 281bd81d-7fcc-4cce-9a7c-db9eff858bb0
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
function onecolslide(content; title="Title", section="Theory", references="", slide_number="?", author=parameters["authors"], align="center",con_font_size=[30])
    if (references != "")
        slide = @htl("""
	<style>
    	.contentones{
    		max-height: 775px;
            overflow: hidden;
    		margin-bottom: 2px;
    		background-color: white;
    		color: black;
    		padding: 10px 10px;
    		text-align: $align;
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
            <h1 class="title-box" align="center">
    	<div align="center;margin-top: 1px;">
    	$title
    	</h1>
            <div class="contentones" style="text-align: $align;">
    		<div style="font-size: $(con_font_size[1])px;">
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
    	.title {
        font-size: 42px;
    }
    	.contentoness{
    		max-height: 775px;
            overflow: hidden;
    		margin-bottom: 2px;
    		background-color: white;
    		color: black;
    		padding: 10px 10px;
    		text-align: $align;
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
            <h1 class="title-box" align="center">
    	<div align="center;margin-top: 1px;">
    	$title
    	</h1>
            <div class="contentoness" style="text-align: $align;">
    		<div style="font-size: $(con_font_size[1])px;">
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

# ╔═╡ 455413fc-f8f1-4c58-a066-d1adef47d897
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
function threecolslide(content_vec; title="Title", section="Theory", references="", slide_number="?", author=parameters["authors"])
	   if (references != "")
    slide = @htl("""
<style>
	.title {
    font-size: 42px;
}
	.content{
		max-height: 775px;
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
        <h1 class="title-box" align="center">
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
	   else
		   slide = @htl("""
<style>
	.title {
    font-size: 42px;
}
	.content{
		max-height: 775px;
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
        <h1 class="title-box" align="center">
	<div align="center;margin-top: 1px;">
	$title
	</h1>
        <div class="content">
	  <div style="display: flex; font-size: 30px;"><div style="flex: auto; margin-right: 10px; text-align: justify;">
        $(content_vec[1])
    </div>
    <div style="flex: auto; margin-left: 10px; text-align: justify;">
        $(content_vec[2])
    </div>
	<div style="flex: auto; margin-left: 10px; text-align: justify;">
        $(content_vec[3])
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

# ╔═╡ 1f9175e4-c07d-499c-9db9-188e557aa260
TableOfContents(include_definitions=true)

# ╔═╡ d38b1826-2752-450d-b80e-d2368812619c
# ╠═╡ disabled = true
#=╠═╡
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
function twocolslide(content_vec; title="Title", section="Theory", references="", slide_number="?", author=parameters["authors"], align=["justify", "justify"], spacing="auto")
        slide = @htl("""
    <style>
    	.title {
        font-size: 30px;
    }
    	.content{
			flex: 1;
    		max-height: 775px;
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
    	  <div style="display: flex; font-size: 30px;"><div style="flex: $(spacing); margin-right: 5px; text-align:$(align[1]);">
            $(content_vec[1])
        </div>
        <div style="flex: $(spacing); margin-left: 5px; text-align: $(align[2]);">
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
    return slide
end
  ╠═╡ =#

# ╔═╡ 8312eb51-5f37-40b6-926a-27e6a35232da
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
function twocolslide(content_vec; title="Title", section="Theory", references="", slide_number="?", author=parameters["authors"], align=["justify", "justify"], spacing=[1, 1],con_font_size=[32])
   if (references != "")
	slide = @htl("""
    <style>
        .title {
            font-size: 30px;
        }
        .content {
            flex: 1;
            max-height: 775px;
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
            padding: 5px 10px;
            background-color: #3333B2;
            color: #fff;
            border-radius: 10px;
            font-size: 24px;
        }
        .title-box {
            margin-top: 10px;
            padding: 5px 10px;
            background-color: #3333B2;
            color: white;
            border-radius: 10px;
            font-size: 42px;
        }
    </style>
    <div class="slide">
        <h1 class="title-box" align="center">
            $title
        </h1>
        <div class="content" style="display: flex; font-size: $(con_font_size[1])px;">
            <div style="flex: $(spacing[1]); margin-right: 5px; text-align: $(align[1]);">
                $(content_vec[1])
            </div>
            <div style="flex: $(spacing[2]); margin-left: 5px; text-align: $(align[2]);">
                $(content_vec[2])
            </div>
        </div>
        <div class="references">
            <div style="font-style: italic; text-align: left;">
                $references
            </div>
        </div>
        <div class="slide-number-box">
            <div style="display: flex; font-size: 24px;">
                <div style="flex: 33%; text-align: left;">
                    $author
                </div>
                <div style="flex: 33%; text-align: center;">
                    $section
                </div>
                <div style="flex: 33%; text-align: right;">
                    $slide_number
                </div>
            </div>
        </div>
    </div>
    """)
   else
	   	slide = @htl("""
    <style>
        .title {
            font-size: 30px;
        }
        .content {
            flex: 1;
            max-height: 775px;
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
            padding: 5px 10px;
            background-color: #3333B2;
            color: #fff;
            border-radius: 10px;
            font-size: 24px;
        }
        .title-box {
            margin-top: 10px;
            padding: 5px 10px;
            background-color: #3333B2;
            color: white;
            border-radius: 10px;
            font-size: 42px;
        }
    </style>
    <div class="slide">
        <h1 class="title-box" align="center">
            $title
        </h1>
        <div class="content" style="display: flex; font-size: $(con_font_size[1])px;">
            <div style="flex: $(spacing[1]); margin-right: 5px; text-align: $(align[1]);">
                $(content_vec[1])
            </div>
            <div style="flex: $(spacing[2]); margin-left: 5px; text-align: $(align[2]);">
                $(content_vec[2])
            </div>
        </div>
        <div class="slide-number-box">
            <div style="display: flex; font-size: 24px;">
                <div style="flex: 33%; text-align: left;">
                    $author
                </div>
                <div style="flex: 33%; text-align: center;">
                    $section
                </div>
                <div style="flex: 33%; text-align: right;">
                    $slide_number
                </div>
            </div>
        </div>
    </div>
    """)
   end
    return slide
end


# ╔═╡ 00000000-0000-0000-0000-000000000001
PLUTO_PROJECT_TOML_CONTENTS = """
[deps]
HypertextLiteral = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
LaTeXStrings = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
Markdown = "d6f4376e-aef5-505a-96c1-9c027394607a"
PlutoHooks = "0ff47ea0-7a50-410d-8455-4348d5de0774"
PlutoLinks = "0ff47ea0-7a50-410d-8455-4348d5de0420"
PlutoUI = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
TOML = "fa267f1f-6049-4f14-aa54-33bafae1ed76"

[compat]
HypertextLiteral = "~0.9.5"
LaTeXStrings = "~1.3.1"
PlutoHooks = "~0.0.5"
PlutoLinks = "~0.1.6"
PlutoUI = "~0.7.59"
"""

# ╔═╡ 00000000-0000-0000-0000-000000000002
PLUTO_MANIFEST_TOML_CONTENTS = """
# This file is machine-generated - editing it directly is not advised

julia_version = "1.11.1"
manifest_format = "2.0"
project_hash = "710c5d9c9a6eeda1993ad5b386e07da2dd934215"

[[deps.AbstractPlutoDingetjes]]
deps = ["Pkg"]
git-tree-sha1 = "6e1d2a35f2f90a4bc7c2ed98079b2ba09c35b83a"
uuid = "6e696c72-6542-2067-7265-42206c756150"
version = "1.3.2"

[[deps.ArgTools]]
uuid = "0dad84c5-d112-42e6-8d28-ef12dabb789f"
version = "1.1.2"

[[deps.Artifacts]]
uuid = "56f22d72-fd6d-98f1-02f0-08ddc0907c33"
version = "1.11.0"

[[deps.Base64]]
uuid = "2a0f44e3-6c83-55bd-87e4-b1978d98bd5f"
version = "1.11.0"

[[deps.CodeTracking]]
deps = ["InteractiveUtils", "UUIDs"]
git-tree-sha1 = "7eee164f122511d3e4e1ebadb7956939ea7e1c77"
uuid = "da1fd8a2-8d9e-5ec2-8556-3022fb5608a2"
version = "1.3.6"

[[deps.ColorTypes]]
deps = ["FixedPointNumbers", "Random"]
git-tree-sha1 = "b10d0b65641d57b8b4d5e234446582de5047050d"
uuid = "3da002f7-5984-5a60-b8a6-cbb66c0b333f"
version = "0.11.5"

[[deps.CompilerSupportLibraries_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "e66e0078-7015-5450-92f7-15fbd957f2ae"
version = "1.1.1+0"

[[deps.Dates]]
deps = ["Printf"]
uuid = "ade2ca70-3891-5945-98fb-dc099432e06a"
version = "1.11.0"

[[deps.Distributed]]
deps = ["Random", "Serialization", "Sockets"]
uuid = "8ba89e20-285c-5b6f-9357-94700520ee1b"
version = "1.11.0"

[[deps.Downloads]]
deps = ["ArgTools", "FileWatching", "LibCURL", "NetworkOptions"]
uuid = "f43a241f-c20a-4ad4-852c-f6b1247861c6"
version = "1.6.0"

[[deps.FileWatching]]
uuid = "7b1f6079-737a-58dc-b8bc-7a2ca5c1b5ee"
version = "1.11.0"

[[deps.FixedPointNumbers]]
deps = ["Statistics"]
git-tree-sha1 = "05882d6995ae5c12bb5f36dd2ed3f61c98cbb172"
uuid = "53c48c17-4a7d-5ca2-90c5-79b7896eea93"
version = "0.8.5"

[[deps.Hyperscript]]
deps = ["Test"]
git-tree-sha1 = "179267cfa5e712760cd43dcae385d7ea90cc25a4"
uuid = "47d2ed2b-36de-50cf-bf87-49c2cf4b8b91"
version = "0.0.5"

[[deps.HypertextLiteral]]
deps = ["Tricks"]
git-tree-sha1 = "7134810b1afce04bbc1045ca1985fbe81ce17653"
uuid = "ac1192a8-f4b3-4bfe-ba22-af5b92cd3ab2"
version = "0.9.5"

[[deps.IOCapture]]
deps = ["Logging", "Random"]
git-tree-sha1 = "b6d6bfdd7ce25b0f9b2f6b3dd56b2673a66c8770"
uuid = "b5f81e59-6552-4d32-b1f0-c071b021bf89"
version = "0.2.5"

[[deps.InteractiveUtils]]
deps = ["Markdown"]
uuid = "b77e0a4c-d291-57a0-90e8-8db25a27a240"
version = "1.11.0"

[[deps.JSON]]
deps = ["Dates", "Mmap", "Parsers", "Unicode"]
git-tree-sha1 = "31e996f0a15c7b280ba9f76636b3ff9e2ae58c9a"
uuid = "682c06a0-de6a-54ab-a142-c8b1cf79cde6"
version = "0.21.4"

[[deps.JuliaInterpreter]]
deps = ["CodeTracking", "InteractiveUtils", "Random", "UUIDs"]
git-tree-sha1 = "fc8504eca188aaae4345649ca6105806bc584b70"
uuid = "aa1ae85d-cabe-5617-a682-6adf51b2e16a"
version = "0.9.37"

[[deps.LaTeXStrings]]
git-tree-sha1 = "50901ebc375ed41dbf8058da26f9de442febbbec"
uuid = "b964fa9f-0449-5b57-a5c2-d3ea65f4040f"
version = "1.3.1"

[[deps.LibCURL]]
deps = ["LibCURL_jll", "MozillaCACerts_jll"]
uuid = "b27032c2-a3e7-50c8-80cd-2d36dbcbfd21"
version = "0.6.4"

[[deps.LibCURL_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll", "Zlib_jll", "nghttp2_jll"]
uuid = "deac9b47-8bc7-5906-a0fe-35ac56dc84c0"
version = "8.6.0+0"

[[deps.LibGit2]]
deps = ["Base64", "LibGit2_jll", "NetworkOptions", "Printf", "SHA"]
uuid = "76f85450-5226-5b5a-8eaa-529ad045b433"
version = "1.11.0"

[[deps.LibGit2_jll]]
deps = ["Artifacts", "LibSSH2_jll", "Libdl", "MbedTLS_jll"]
uuid = "e37daf67-58a4-590a-8e99-b0245dd2ffc5"
version = "1.7.2+0"

[[deps.LibSSH2_jll]]
deps = ["Artifacts", "Libdl", "MbedTLS_jll"]
uuid = "29816b5a-b9ab-546f-933c-edad1886dfa8"
version = "1.11.0+1"

[[deps.Libdl]]
uuid = "8f399da3-3557-5675-b5ff-fb832c97cbdb"
version = "1.11.0"

[[deps.LinearAlgebra]]
deps = ["Libdl", "OpenBLAS_jll", "libblastrampoline_jll"]
uuid = "37e2e46d-f89d-539d-b4ee-838fcccc9c8e"
version = "1.11.0"

[[deps.Logging]]
uuid = "56ddb016-857b-54e1-b83d-db4d58db5568"
version = "1.11.0"

[[deps.LoweredCodeUtils]]
deps = ["JuliaInterpreter"]
git-tree-sha1 = "260dc274c1bc2cb839e758588c63d9c8b5e639d1"
uuid = "6f1432cf-f94c-5a45-995e-cdbf5db27b0b"
version = "3.0.5"

[[deps.MIMEs]]
git-tree-sha1 = "65f28ad4b594aebe22157d6fac869786a255b7eb"
uuid = "6c6e2e6c-3030-632d-7369-2d6c69616d65"
version = "0.1.4"

[[deps.Markdown]]
deps = ["Base64"]
uuid = "d6f4376e-aef5-505a-96c1-9c027394607a"
version = "1.11.0"

[[deps.MbedTLS_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "c8ffd9c3-330d-5841-b78e-0817d7145fa1"
version = "2.28.6+0"

[[deps.Mmap]]
uuid = "a63ad114-7e13-5084-954f-fe012c677804"
version = "1.11.0"

[[deps.MozillaCACerts_jll]]
uuid = "14a3606d-f60d-562e-9121-12d972cd8159"
version = "2023.12.12"

[[deps.NetworkOptions]]
uuid = "ca575930-c2e3-43a9-ace4-1e988b2c1908"
version = "1.2.0"

[[deps.OpenBLAS_jll]]
deps = ["Artifacts", "CompilerSupportLibraries_jll", "Libdl"]
uuid = "4536629a-c528-5b80-bd46-f80d51c5b363"
version = "0.3.27+1"

[[deps.OrderedCollections]]
git-tree-sha1 = "dfdf5519f235516220579f949664f1bf44e741c5"
uuid = "bac558e1-5e72-5ebc-8fee-abe8a469f55d"
version = "1.6.3"

[[deps.Parsers]]
deps = ["Dates", "PrecompileTools", "UUIDs"]
git-tree-sha1 = "8489905bcdbcfac64d1daa51ca07c0d8f0283821"
uuid = "69de0a69-1ddd-5017-9359-2bf0b02dc9f0"
version = "2.8.1"

[[deps.Pkg]]
deps = ["Artifacts", "Dates", "Downloads", "FileWatching", "LibGit2", "Libdl", "Logging", "Markdown", "Printf", "Random", "SHA", "TOML", "Tar", "UUIDs", "p7zip_jll"]
uuid = "44cfe95a-1eb2-52ea-b672-e2afdf69b78f"
version = "1.11.0"
weakdeps = ["REPL"]

    [deps.Pkg.extensions]
    REPLExt = "REPL"

[[deps.PlutoHooks]]
deps = ["InteractiveUtils", "Markdown", "UUIDs"]
git-tree-sha1 = "072cdf20c9b0507fdd977d7d246d90030609674b"
uuid = "0ff47ea0-7a50-410d-8455-4348d5de0774"
version = "0.0.5"

[[deps.PlutoLinks]]
deps = ["FileWatching", "InteractiveUtils", "Markdown", "PlutoHooks", "Revise", "UUIDs"]
git-tree-sha1 = "8f5fa7056e6dcfb23ac5211de38e6c03f6367794"
uuid = "0ff47ea0-7a50-410d-8455-4348d5de0420"
version = "0.1.6"

[[deps.PlutoUI]]
deps = ["AbstractPlutoDingetjes", "Base64", "ColorTypes", "Dates", "FixedPointNumbers", "Hyperscript", "HypertextLiteral", "IOCapture", "InteractiveUtils", "JSON", "Logging", "MIMEs", "Markdown", "Random", "Reexport", "URIs", "UUIDs"]
git-tree-sha1 = "eba4810d5e6a01f612b948c9fa94f905b49087b0"
uuid = "7f904dfe-b85e-4ff6-b463-dae2292396a8"
version = "0.7.60"

[[deps.PrecompileTools]]
deps = ["Preferences"]
git-tree-sha1 = "5aa36f7049a63a1528fe8f7c3f2113413ffd4e1f"
uuid = "aea7be01-6a6a-4083-8856-8a6e6704d82a"
version = "1.2.1"

[[deps.Preferences]]
deps = ["TOML"]
git-tree-sha1 = "9306f6085165d270f7e3db02af26a400d580f5c6"
uuid = "21216c6a-2e73-6563-6e65-726566657250"
version = "1.4.3"

[[deps.Printf]]
deps = ["Unicode"]
uuid = "de0858da-6303-5e67-8744-51eddeeeb8d7"
version = "1.11.0"

[[deps.REPL]]
deps = ["InteractiveUtils", "Markdown", "Sockets", "StyledStrings", "Unicode"]
uuid = "3fa0cd96-eef1-5676-8a61-b3b8758bbffb"
version = "1.11.0"

[[deps.Random]]
deps = ["SHA"]
uuid = "9a3f8284-a2c9-5f02-9a11-845980a1fd5c"
version = "1.11.0"

[[deps.Reexport]]
git-tree-sha1 = "45e428421666073eab6f2da5c9d310d99bb12f9b"
uuid = "189a3867-3050-52da-a836-e630ba90ab69"
version = "1.2.2"

[[deps.Requires]]
deps = ["UUIDs"]
git-tree-sha1 = "838a3a4188e2ded87a4f9f184b4b0d78a1e91cb7"
uuid = "ae029012-a4dd-5104-9daa-d747884805df"
version = "1.3.0"

[[deps.Revise]]
deps = ["CodeTracking", "Distributed", "FileWatching", "JuliaInterpreter", "LibGit2", "LoweredCodeUtils", "OrderedCollections", "REPL", "Requires", "UUIDs", "Unicode"]
git-tree-sha1 = "834aedb1369919a7b2026d7e04c2d49a311d26f4"
uuid = "295af30f-e4ad-537b-8983-00126c2a3abe"
version = "3.6.3"

[[deps.SHA]]
uuid = "ea8e919c-243c-51af-8825-aaa63cd721ce"
version = "0.7.0"

[[deps.Serialization]]
uuid = "9e88b42a-f829-5b0c-bbe9-9e923198166b"
version = "1.11.0"

[[deps.Sockets]]
uuid = "6462fe0b-24de-5631-8697-dd941f90decc"
version = "1.11.0"

[[deps.Statistics]]
deps = ["LinearAlgebra"]
git-tree-sha1 = "ae3bb1eb3bba077cd276bc5cfc337cc65c3075c0"
uuid = "10745b16-79ce-11e8-11f9-7d13ad32a3b2"
version = "1.11.1"

    [deps.Statistics.extensions]
    SparseArraysExt = ["SparseArrays"]

    [deps.Statistics.weakdeps]
    SparseArrays = "2f01184e-e22b-5df5-ae63-d93ebab69eaf"

[[deps.StyledStrings]]
uuid = "f489334b-da3d-4c2e-b8f0-e476e12c162b"
version = "1.11.0"

[[deps.TOML]]
deps = ["Dates"]
uuid = "fa267f1f-6049-4f14-aa54-33bafae1ed76"
version = "1.0.3"

[[deps.Tar]]
deps = ["ArgTools", "SHA"]
uuid = "a4e569a6-e804-4fa4-b0f3-eef7a1d5b13e"
version = "1.10.0"

[[deps.Test]]
deps = ["InteractiveUtils", "Logging", "Random", "Serialization"]
uuid = "8dfed614-e22c-5e08-85e1-65c5234f0b40"
version = "1.11.0"

[[deps.Tricks]]
git-tree-sha1 = "7822b97e99a1672bfb1b49b668a6d46d58d8cbcb"
uuid = "410a4b4d-49e4-4fbc-ab6d-cb71b17b3775"
version = "0.1.9"

[[deps.URIs]]
git-tree-sha1 = "67db6cc7b3821e19ebe75791a9dd19c9b1188f2b"
uuid = "5c2747f8-b7ea-4ff2-ba2e-563bfd36b1d4"
version = "1.5.1"

[[deps.UUIDs]]
deps = ["Random", "SHA"]
uuid = "cf7118a7-6976-5b1a-9a39-7adc72f591a4"
version = "1.11.0"

[[deps.Unicode]]
uuid = "4ec0a83e-493e-50e2-b9ac-8f72acf5a8f5"
version = "1.11.0"

[[deps.Zlib_jll]]
deps = ["Libdl"]
uuid = "83775a58-1f1d-513f-b197-d71354ab007a"
version = "1.2.13+1"

[[deps.libblastrampoline_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850b90-86db-534c-a0d3-1478176c7d93"
version = "5.11.0+0"

[[deps.nghttp2_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "8e850ede-7688-5339-a07c-302acd2aaf8d"
version = "1.59.0+0"

[[deps.p7zip_jll]]
deps = ["Artifacts", "Libdl"]
uuid = "3f19e933-33d8-53b3-aaab-bd5110c3b7a0"
version = "17.4.0+2"
"""

# ╔═╡ Cell order:
# ╟─e18ba3dd-013f-4a1e-abe7-9ff9c4d61e68
# ╠═8907ddc3-09b3-4983-8c45-4c431ef31a7f
# ╠═44f58c83-a344-4282-ba3f-c76e09bf2f27
# ╠═f912a32d-8c46-4e3d-bde5-4893ba74b416
# ╠═a6496eb0-3fcd-4382-805a-61625d6f4eb5
# ╠═cb68d0e3-1c63-4141-812a-566e05e95c25
# ╠═4c7c8965-8b82-4706-ab31-98cb26dab635
# ╠═98338d28-6fca-46ef-801f-d86ed2f75205
# ╠═281bd81d-7fcc-4cce-9a7c-db9eff858bb0
# ╠═455413fc-f8f1-4c58-a066-d1adef47d897
# ╠═8312eb51-5f37-40b6-926a-27e6a35232da
# ╠═d38b1826-2752-450d-b80e-d2368812619c
# ╠═6c18c41f-ee57-4fb1-8499-f7e4b89c1a3c
# ╠═230aef68-badf-4002-bfcf-e83b8c192a80
# ╠═981ff634-c20b-46d5-9c0a-2bf6fec0af91
# ╠═2210f32d-829e-4efe-a072-d478fcc18488
# ╠═0bbc0291-7415-40dc-b6f1-2521c8cc356c
# ╠═1f9175e4-c07d-499c-9db9-188e557aa260
# ╟─00000000-0000-0000-0000-000000000001
# ╟─00000000-0000-0000-0000-000000000002
