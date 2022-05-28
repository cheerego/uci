<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;
use Illuminate\Database\Eloquent\SoftDeletes;

class Workflow extends Model
{
    use HasFactory;
    use SoftDeletes;

    protected $table = "workflows";

    protected $casts = [
        'param_envs' => 'json',
    ];


    public function getParamEnvsAttribute($value)
    {
        return array_values(json_decode($value, true) ?: []);
    }

    public function setParamEnvsAttribute($value)
    {
        $this->attributes['param_envs'] = json_encode(array_values($value));
    }

}
