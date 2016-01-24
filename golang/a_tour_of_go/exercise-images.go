package main

import (
	"golang.org/x/tour/pic"
	"image"
	"image/color"
)

type Image struct {
	w, h int
}

func (r *Image) ColorModel() color.Model {
	return color.RGBAModel
}

func (r *Image) Bounds() image.Rectangle {
	return image.Rect(0, 0, r.w, r.h)
}

func (r *Image) At(x, y int) color.Color {
	return color.RGBA{uint8(x), uint8(y), 255, 255}
}

func main() {
	m := &Image{256, 256}
	pic.ShowImage(m)
}
