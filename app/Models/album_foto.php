<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class album_foto extends Model
{
    use HasFactory;

    protected $table = 'album_fotos';

    protected $fillable = [
        'nombre_album',
        'descripcion',
        'portada',
        'aprobado',
        'id_fotoestudio',
    ];

    public function fotos()
    {
        return $this->hasMany(foto::class);
    }

    public function album()
    {
        return $this->belongsTo(User::class);
    }

    public function detalle_album_evento()
    {
        return $this->hasMany(detalle_album_evento::class);
    }

    public function detalle_album_cliente()
    {
        return $this->hasMany(detalle_album_cliente::class);
    }
}
