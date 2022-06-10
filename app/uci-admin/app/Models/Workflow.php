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
        'envs' => 'json',
    ];


    public function getEnvsAttribute($value)
    {
        return array_values(json_decode($value, true) ?: []);
    }

    public function setEnvsAttribute($value)
    {
        $this->attributes['envs'] = json_encode(array_values($value));
    }

}
