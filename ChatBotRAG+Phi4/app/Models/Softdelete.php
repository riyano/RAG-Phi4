<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Softdelete extends Model
{
    use HasFactory;

    protected $table = 'softdeletes';
    const UPDATED_AT = null; // Kita tidak butuh kolom updated_at

    protected $fillable = [
        'user_id',
        'session_id',
        'original_filename',
        'stored_path', // Pastikan kolom ini ada di fillable
        'deleted_at',
    ];
}
