<?php

namespace App\Admin\Extensions;


namespace App\Admin\Extensions;

use Encore\Admin\Form\Field;

class PHPEditor extends Field
{
    protected $view = 'admin.php-editor';

    protected static $css = [
        'https://cdn.jsdelivr.net/npm/codemirror@5.57.0/lib/codemirror.css'
    ];


    protected static $js = [
        'https://cdn.jsdelivr.net/npm/codemirror@5.57.0/lib/codemirror.min.js',
        'https://cdn.jsdelivr.net/npm/codemirror@5.57.0/addon/edit/matchbrackets.js',
        'https://cdn.jsdelivr.net/npm/codemirror@5.57.0/mode/htmlmixed/htmlmixed.js',
        'https://cdn.jsdelivr.net/npm/codemirror@5.57.0/mode/xml/xml.js',
        'https://cdn.jsdelivr.net/npm/codemirror@5.57.0/mode/javascript/javascript.js',
        'https://cdn.jsdelivr.net/npm/codemirror@5.57.0/mode/css/css.js',
        'https://cdn.jsdelivr.net/npm/codemirror@5.57.0/mode/clike/clike.js',
        'https://cdn.jsdelivr.net/npm/codemirror@5.57.0/mode/php/php.js',
        'https://cdn.jsdelivr.net/npm/codemirror@5.57.0/mode/yaml/yaml.js',
    ];

    public function render()
    {
        $id = $this->id;
        $this->script = <<<EOT

CodeMirror.fromTextArea(document.getElementById("{$id}"), {
    lineNumbers: true,
    mode: "text/x-text/x-yaml",
    extraKeys: {
        "Tab": function(cm){
            cm.replaceSelection("    " , "end");
        }
     }
});

EOT;
        return parent::render();

    }
}
