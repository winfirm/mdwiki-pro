MDwiki-pro
======

Bases on the popular stable [MDwiki](https://github.com/Dynalon/mdwiki) version 0.6.2.

Uses [markdown-it](https://github.com/markdown-it/markdown-it)(ver 3.0.2) & [markdown-it-multimd-table](https://github.com/redbug312/markdown-it-multimd-table)(ver 4.2.3) as MarkDown parser.

Supports Markdown with table spans over columns/rows.

It's also 100% static single file CMS/Wiki done purely with client-side Javascript and HTML5.

# Live Demo site

[MDwiki-pro docs site](https://winfirm.net/mdwiki-pro)


# Newest Release 
[mdwiki-pro-1.0.1.zip](https://github.com/winfirm/mdwiki-pro/releases/download/1.0.1/mdwiki-1.0.1.zip)

# Implementing way

First, package markdown-it and markdown-it-multimd-table to `js/markdonw-it.js`, export marked as parse method:
```
  /**
   * Just as marked.js, export marked to parse Markdown
   * @param {*} src  input markdonw format string
   * @param {*} opt  ignore in markdown-it
   * @param {*} callback  ignore in markdown-it
   * @returns 
   */
  function marked(src, opt, callback) {
    var md = MarkdownIt({
      html: true,
      linkify: true,
      typographer: true
    });

    md.use(markdownitMultimdTable(), {
      multiline: true,
      rowspan: true,
      headerless: false,
      multibody: true,
      autolabel: true,
    });
    return md.render(src);
  }

  marked.setOptions=function(option){
    //not need by markdown-it
  }
```

then, marked.js to markdown-it.js in `Gruntfile.js`: 
```
        ownJsFiles: [
            //'js/marked.js',
            'js/markdown-it.js',
```

finally, build project.

# Build steps

1. Install node.js >= 0.8 and npm (if not included)
2. Clone this repo
3. Build MDwiki-pro
    make
4. Find the `mdwiki.html` in `dist/` folder


# Table spans Usage

#### Basic MdWiki Usage

Please read [MdWiki official site](http://dynalon.github.io/mdwiki/#!index.md)

#### Markdown table syntax support by MDwiki-pro

```
|                       Grouping           |||
|First Header  | Second Header | Third Header |
|------------ | :-----------: | -----------: |
|Content       |          *Long Cell*        ||
|^^|   **Cell**    |         Cell |
|New section   |     More      |         Data |
|And more      | With an escaped '\\|'       ||
```

table expected on browser:
<table>
<thead>
<tr>
<th></th>
<th align="center" colspan="2">Grouping</th>
</tr>
<tr>
<th>First Header</th>
<th align="center">Second Header</th>
<th align="right">Third Header</th>
</tr>
</thead>
<tbody>
<tr>
<td>Content</td>
<td align="center" colspan="2"><em>Long Cell</em></td>
</tr>
<tr>
<td>Content</td>
<td align="center"><strong>Cell</strong></td>
<td align="right">Cell</td>
</tr>
</tbody>
<tbody>
<tr>
<td>New section</td>
<td align="center">More</td>
<td align="right">Data</td>
</tr>
<tr>
<td>And more</td>
<td align="center" colspan="2">With an escaped '|'</td>
</tr>
</tbody>
<caption id="prototypetable">Prototype table</caption>
</table>

More info about table usage:[markdown-it-multimd-table](https://github.com/redbug312/markdown-it-multimd-table)


# Another Implementing way

Just takes online version of markdown-it and markdown-it-multimd-table to render markdown inputs: 

first, remove 'js/marked.js` in `Gruntfile.js`
```
        ownJsFiles: [
            //'js/marked.js',
```

second, load online version of markdown-it and markdown-it-multimd-table in imdex.tmpl

```
<script src="https://cdn.jsdelivr.net/npm/markdown-it@13.0.2/dist/markdown-it.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/markdown-it-multimd-table@4.2.3/dist/markdown-it-multimd-table.min.js" type="text/javascript"></script>
```

then, replace marked by markdownit and markdownitMultimdTable in `js/main.js`

```
    //var uglyHtml = marked(markdown);

    var markedIt = window.markdownit().use(window.markdownitMultimdTable, {
            multiline:  true,
            rowspan:    true,
            headerless: false,
            multibody:  true,
            aotolabel:  true,
        });
    var uglyHtml = markedIt.render(markdown);
```

```
    // var navHtml = marked(navMD);
    var markedIt = window.markdownit().use(window.markdownitMultimdTable, {
        multiline:  true,
        rowspan:    true,
        headerless: false,
        multibody:  true,
        aotolabel:  true,
        });

    var navHtml = markedIt.render(navMD);
```

finally , build project.
