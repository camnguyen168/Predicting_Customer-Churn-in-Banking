---
title: "Exercise"
output: 
  html_document:
    keep_md: yes
date: "2026-04-25"
editor_options: 
  chunk_output_type: console
---
# Data Exploration

## Data

``` r
knitr::knit_hooks$set(small.mar = function(before) {
    if (before) par(mar = c(1, 1, 1, 1))  
})
```

``` r
library(gt)
library(dplyr)
library(tibble) # Required for rownames_to_column
library(gtExtras)
mtcars %>%
  head(10) %>%
  # 1. Convert row names to a column
  rownames_to_column(var = "model") %>% 
  # 2. Tell gt() to use 'model' as the Stub
  gt(rowname_col = "model") %>% gt_theme_excel() %>% 
  # 3. Add titles
  
  tab_header(
    title = "Motor Trend Car Road Tests",
    subtitle = "Data from the 1974 Motor Trend US magazine"
  ) %>%
  # 4. Label the header area above the stub
  tab_stubhead(label = "Car Model") %>%
  # 5. Round 'disp' to one decimal place
  fmt_number(
    columns = disp,
    decimals = 1
  ) %>%
  # 6. Round 'wt' to three decimal places
  fmt_number(
    columns = wt,
    decimals = 3
  ) %>%
  # 7. Final column labeling (all in one place)
  cols_label(
    mpg = "Miles Per Gallon",
    disp = "Displacement",
    wt = "Weight"
  ) 
```

```{=html}
<div id="kvmqvgewjl" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#kvmqvgewjl table {
  font-family: Calibri, system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#kvmqvgewjl thead, #kvmqvgewjl tbody, #kvmqvgewjl tfoot, #kvmqvgewjl tr, #kvmqvgewjl td, #kvmqvgewjl th {
  border-style: none;
}

#kvmqvgewjl p {
  margin: 0;
  padding: 0;
}

#kvmqvgewjl .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #000000;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #000000;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #000000;
  border-left-style: solid;
  border-left-width: 2px;
  border-left-color: #000000;
}

#kvmqvgewjl .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#kvmqvgewjl .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#kvmqvgewjl .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#kvmqvgewjl .gt_heading {
  background-color: #FFFFFF;
  text-align: left;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#kvmqvgewjl .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #000000;
}

#kvmqvgewjl .gt_col_headings {
  border-top-style: none;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #000000;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#kvmqvgewjl .gt_col_heading {
  color: #FFFFFF;
  background-color: #000000;
  font-size: 85%;
  font-weight: bold;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#kvmqvgewjl .gt_column_spanner_outer {
  color: #FFFFFF;
  background-color: #000000;
  font-size: 85%;
  font-weight: bold;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#kvmqvgewjl .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#kvmqvgewjl .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#kvmqvgewjl .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #000000;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#kvmqvgewjl .gt_spanner_row {
  border-bottom-style: hidden;
}

#kvmqvgewjl .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #000000;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #000000;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #000000;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #000000;
  vertical-align: middle;
  text-align: left;
}

#kvmqvgewjl .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #000000;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #000000;
  vertical-align: middle;
}

#kvmqvgewjl .gt_from_md > :first-child {
  margin-top: 0;
}

#kvmqvgewjl .gt_from_md > :last-child {
  margin-bottom: 0;
}

#kvmqvgewjl .gt_row {
  padding-top: 1px;
  padding-bottom: 1px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #000000;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #000000;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #000000;
  vertical-align: middle;
  overflow-x: hidden;
}

#kvmqvgewjl .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #000000;
  padding-left: 5px;
  padding-right: 5px;
}

#kvmqvgewjl .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#kvmqvgewjl .gt_row_group_first td {
  border-top-width: 2px;
}

#kvmqvgewjl .gt_row_group_first th {
  border-top-width: 2px;
}

#kvmqvgewjl .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#kvmqvgewjl .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#kvmqvgewjl .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#kvmqvgewjl .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#kvmqvgewjl .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#kvmqvgewjl .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#kvmqvgewjl .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#kvmqvgewjl .gt_striped {
  background-color: #D3D3D3;
}

#kvmqvgewjl .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#kvmqvgewjl .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#kvmqvgewjl .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#kvmqvgewjl .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#kvmqvgewjl .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#kvmqvgewjl .gt_left {
  text-align: left;
}

#kvmqvgewjl .gt_center {
  text-align: center;
}

#kvmqvgewjl .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#kvmqvgewjl .gt_font_normal {
  font-weight: normal;
}

#kvmqvgewjl .gt_font_bold {
  font-weight: bold;
}

#kvmqvgewjl .gt_font_italic {
  font-style: italic;
}

#kvmqvgewjl .gt_super {
  font-size: 65%;
}

#kvmqvgewjl .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#kvmqvgewjl .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#kvmqvgewjl .gt_indent_1 {
  text-indent: 5px;
}

#kvmqvgewjl .gt_indent_2 {
  text-indent: 10px;
}

#kvmqvgewjl .gt_indent_3 {
  text-indent: 15px;
}

#kvmqvgewjl .gt_indent_4 {
  text-indent: 20px;
}

#kvmqvgewjl .gt_indent_5 {
  text-indent: 25px;
}

#kvmqvgewjl .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#kvmqvgewjl div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_heading">
      <td colspan="12" class="gt_heading gt_title gt_font_normal" style>Motor Trend Car Road Tests</td>
    </tr>
    <tr class="gt_heading">
      <td colspan="12" class="gt_heading gt_subtitle gt_font_normal gt_bottom_border" style>Data from the 1974 Motor Trend US magazine</td>
    </tr>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="a::stub">Car Model</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="mpg">Miles Per Gallon</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="cyl">cyl</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="disp">Displacement</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="hp">hp</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="drat">drat</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="wt">Weight</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="qsec">qsec</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="vs">vs</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="am">am</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" scope="col" id="gear">gear</th>
      <th class="gt_col_heading gt_columns_bottom_border gt_right" rowspan="1" colspan="1" style="border-right-width: 2px; border-right-style: solid; border-right-color: black;" scope="col" id="carb">carb</th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><th id="stub_1_1" scope="row" class="gt_row gt_left gt_stub" style="border-left-width: 2px; border-left-style: solid; border-left-color: black;">Mazda RX4</th>
<td headers="stub_1_1 mpg" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">21.0</td>
<td headers="stub_1_1 cyl" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">6</td>
<td headers="stub_1_1 disp" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">160.0</td>
<td headers="stub_1_1 hp" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">110</td>
<td headers="stub_1_1 drat" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">3.90</td>
<td headers="stub_1_1 wt" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">2.620</td>
<td headers="stub_1_1 qsec" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">16.46</td>
<td headers="stub_1_1 vs" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">0</td>
<td headers="stub_1_1 am" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">1</td>
<td headers="stub_1_1 gear" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">4</td>
<td headers="stub_1_1 carb" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 2px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">4</td></tr>
    <tr><th id="stub_1_2" scope="row" class="gt_row gt_left gt_stub" style="border-left-width: 2px; border-left-style: solid; border-left-color: black;">Mazda RX4 Wag</th>
<td headers="stub_1_2 mpg" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">21.0</td>
<td headers="stub_1_2 cyl" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">6</td>
<td headers="stub_1_2 disp" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">160.0</td>
<td headers="stub_1_2 hp" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">110</td>
<td headers="stub_1_2 drat" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">3.90</td>
<td headers="stub_1_2 wt" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">2.875</td>
<td headers="stub_1_2 qsec" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">17.02</td>
<td headers="stub_1_2 vs" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">0</td>
<td headers="stub_1_2 am" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">1</td>
<td headers="stub_1_2 gear" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">4</td>
<td headers="stub_1_2 carb" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 2px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">4</td></tr>
    <tr><th id="stub_1_3" scope="row" class="gt_row gt_left gt_stub" style="border-left-width: 2px; border-left-style: solid; border-left-color: black;">Datsun 710</th>
<td headers="stub_1_3 mpg" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">22.8</td>
<td headers="stub_1_3 cyl" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">4</td>
<td headers="stub_1_3 disp" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">108.0</td>
<td headers="stub_1_3 hp" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">93</td>
<td headers="stub_1_3 drat" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">3.85</td>
<td headers="stub_1_3 wt" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">2.320</td>
<td headers="stub_1_3 qsec" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">18.61</td>
<td headers="stub_1_3 vs" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">1</td>
<td headers="stub_1_3 am" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">1</td>
<td headers="stub_1_3 gear" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">4</td>
<td headers="stub_1_3 carb" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 2px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">1</td></tr>
    <tr><th id="stub_1_4" scope="row" class="gt_row gt_left gt_stub" style="border-left-width: 2px; border-left-style: solid; border-left-color: black;">Hornet 4 Drive</th>
<td headers="stub_1_4 mpg" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">21.4</td>
<td headers="stub_1_4 cyl" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">6</td>
<td headers="stub_1_4 disp" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">258.0</td>
<td headers="stub_1_4 hp" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">110</td>
<td headers="stub_1_4 drat" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">3.08</td>
<td headers="stub_1_4 wt" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">3.215</td>
<td headers="stub_1_4 qsec" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">19.44</td>
<td headers="stub_1_4 vs" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">1</td>
<td headers="stub_1_4 am" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">0</td>
<td headers="stub_1_4 gear" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">3</td>
<td headers="stub_1_4 carb" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 2px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">1</td></tr>
    <tr><th id="stub_1_5" scope="row" class="gt_row gt_left gt_stub" style="border-left-width: 2px; border-left-style: solid; border-left-color: black;">Hornet Sportabout</th>
<td headers="stub_1_5 mpg" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">18.7</td>
<td headers="stub_1_5 cyl" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">8</td>
<td headers="stub_1_5 disp" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">360.0</td>
<td headers="stub_1_5 hp" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">175</td>
<td headers="stub_1_5 drat" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">3.15</td>
<td headers="stub_1_5 wt" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">3.440</td>
<td headers="stub_1_5 qsec" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">17.02</td>
<td headers="stub_1_5 vs" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">0</td>
<td headers="stub_1_5 am" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">0</td>
<td headers="stub_1_5 gear" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">3</td>
<td headers="stub_1_5 carb" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 2px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">2</td></tr>
    <tr><th id="stub_1_6" scope="row" class="gt_row gt_left gt_stub" style="border-left-width: 2px; border-left-style: solid; border-left-color: black;">Valiant</th>
<td headers="stub_1_6 mpg" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">18.1</td>
<td headers="stub_1_6 cyl" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">6</td>
<td headers="stub_1_6 disp" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">225.0</td>
<td headers="stub_1_6 hp" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">105</td>
<td headers="stub_1_6 drat" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">2.76</td>
<td headers="stub_1_6 wt" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">3.460</td>
<td headers="stub_1_6 qsec" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">20.22</td>
<td headers="stub_1_6 vs" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">1</td>
<td headers="stub_1_6 am" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">0</td>
<td headers="stub_1_6 gear" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">3</td>
<td headers="stub_1_6 carb" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 2px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">1</td></tr>
    <tr><th id="stub_1_7" scope="row" class="gt_row gt_left gt_stub" style="border-left-width: 2px; border-left-style: solid; border-left-color: black;">Duster 360</th>
<td headers="stub_1_7 mpg" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">14.3</td>
<td headers="stub_1_7 cyl" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">8</td>
<td headers="stub_1_7 disp" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">360.0</td>
<td headers="stub_1_7 hp" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">245</td>
<td headers="stub_1_7 drat" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">3.21</td>
<td headers="stub_1_7 wt" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">3.570</td>
<td headers="stub_1_7 qsec" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">15.84</td>
<td headers="stub_1_7 vs" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">0</td>
<td headers="stub_1_7 am" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">0</td>
<td headers="stub_1_7 gear" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">3</td>
<td headers="stub_1_7 carb" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 2px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">4</td></tr>
    <tr><th id="stub_1_8" scope="row" class="gt_row gt_left gt_stub" style="border-left-width: 2px; border-left-style: solid; border-left-color: black;">Merc 240D</th>
<td headers="stub_1_8 mpg" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">24.4</td>
<td headers="stub_1_8 cyl" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">4</td>
<td headers="stub_1_8 disp" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">146.7</td>
<td headers="stub_1_8 hp" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">62</td>
<td headers="stub_1_8 drat" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">3.69</td>
<td headers="stub_1_8 wt" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">3.190</td>
<td headers="stub_1_8 qsec" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">20.00</td>
<td headers="stub_1_8 vs" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">1</td>
<td headers="stub_1_8 am" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">0</td>
<td headers="stub_1_8 gear" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">4</td>
<td headers="stub_1_8 carb" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 2px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">2</td></tr>
    <tr><th id="stub_1_9" scope="row" class="gt_row gt_left gt_stub" style="border-left-width: 2px; border-left-style: solid; border-left-color: black;">Merc 230</th>
<td headers="stub_1_9 mpg" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">22.8</td>
<td headers="stub_1_9 cyl" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">4</td>
<td headers="stub_1_9 disp" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">140.8</td>
<td headers="stub_1_9 hp" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">95</td>
<td headers="stub_1_9 drat" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">3.92</td>
<td headers="stub_1_9 wt" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">3.150</td>
<td headers="stub_1_9 qsec" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">22.90</td>
<td headers="stub_1_9 vs" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">1</td>
<td headers="stub_1_9 am" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">0</td>
<td headers="stub_1_9 gear" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">4</td>
<td headers="stub_1_9 carb" class="gt_row gt_right" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 2px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 1px; border-bottom-style: solid; border-bottom-color: black;">2</td></tr>
    <tr><th id="stub_1_10" scope="row" class="gt_row gt_left gt_stub" style="border-left-width: 2px; border-left-style: solid; border-left-color: black; border-bottom-width: 2px; border-bottom-style: solid; border-bottom-color: black;">Merc 280</th>
<td headers="stub_1_10 mpg" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 2px; border-bottom-style: solid; border-bottom-color: black;">19.2</td>
<td headers="stub_1_10 cyl" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 2px; border-bottom-style: solid; border-bottom-color: black;">6</td>
<td headers="stub_1_10 disp" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 2px; border-bottom-style: solid; border-bottom-color: black;">167.6</td>
<td headers="stub_1_10 hp" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 2px; border-bottom-style: solid; border-bottom-color: black;">123</td>
<td headers="stub_1_10 drat" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 2px; border-bottom-style: solid; border-bottom-color: black;">3.92</td>
<td headers="stub_1_10 wt" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 2px; border-bottom-style: solid; border-bottom-color: black;">3.440</td>
<td headers="stub_1_10 qsec" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 2px; border-bottom-style: solid; border-bottom-color: black;">18.30</td>
<td headers="stub_1_10 vs" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 2px; border-bottom-style: solid; border-bottom-color: black;">1</td>
<td headers="stub_1_10 am" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 2px; border-bottom-style: solid; border-bottom-color: black;">0</td>
<td headers="stub_1_10 gear" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 1px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 2px; border-bottom-style: solid; border-bottom-color: black;">4</td>
<td headers="stub_1_10 carb" class="gt_row gt_right gt_striped" style="border-left-width: 1px; border-left-style: solid; border-left-color: black; border-right-width: 2px; border-right-style: solid; border-right-color: black; border-top-width: 1px; border-top-style: solid; border-top-color: black; border-bottom-width: 2px; border-bottom-style: solid; border-bottom-color: black;">4</td></tr>
  </tbody>
  
</table>
</div>
```
## Visualization

``` r
hist(rnorm(1000))
```

![A histogram of 1000 observation](ExerciseRmarkdown_files/figure-html/unnamed-chunk-3-1.png)
<br>


``` r
library(ggthemes)
library(ggplot2)
# We'll plot MPG vs Horsepower, colored by number of cylinders
# Note: factor(cyl) treats cylinders as categories rather than a continuous number
ggplot(mtcars, aes(x = hp, y = mpg, colour = factor(cyl))) +
  geom_point(size = 3) +
  # 1. Apply the overall visual theme
  theme_fivethirtyeight() +
  # 2. Apply the specific FiveThirtyEight color palette to the points
  scale_colour_fivethirtyeight() +
  # 3. Add labels (Since theme_538 removes axis titles by default, we add them back)
  labs(
    title = "MPG vs Horsepower",
    subtitle = "Grouped by Number of Cylinders",
    x = "Horsepower",
    y = "Miles Per Gallon",
    colour = "Cylinders"
  ) +
  # fivethirtyeight theme hides axis titles; this line brings them back
  theme(axis.title = element_text())
```

![](ExerciseRmarkdown_files/figure-html/unnamed-chunk-4-1.png)<!-- -->

``` r
# 1. Prepare the data: Calculate average MPG per cylinder group
mtcars_summary <- mtcars %>%
  group_by(cyl) %>%
  summarise(avg_mpg = mean(mpg))

# 2. Create the bar chart
ggplot(mtcars_summary, aes(x = factor(cyl), y = avg_mpg, fill = factor(cyl))) +
  geom_col(width = 0.7) +
  # Apply the FiveThirtyEight visual theme
  theme_fivethirtyeight() +
  # Apply the FiveThirtyEight fill colors
  scale_fill_fivethirtyeight() +
  labs(
    title = "Efficiency by Engine Size",
    subtitle = "Average Miles Per Gallon (MPG) by Cylinder Count",
    x = "Number of Cylinders",
    y = "Average MPG"
  ) +
  # Ensure axis titles are visible and hide the redundant legend
  theme(
    axis.title = element_text(),
    legend.position = "none"
  )
```

![](ExerciseRmarkdown_files/figure-html/unnamed-chunk-5-1.png)<!-- -->



``` r
mtcars %>% ggplot(aes(x=wt,y=mpg, colour=as.factor(gear))) +
  geom_point()
```

![](ExerciseRmarkdown_files/figure-html/unnamed-chunk-6-1.png)<!-- -->



