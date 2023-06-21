<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\fotos;
use App\Models\Evento;
use App\Models\similitud;
use App\Models\organizador;
use App\Models\album_evento;
use Illuminate\Http\Request;
use App\Models\album_cliente;
use App\Models\invitacion_evento;
use Intervention\Image\Facades\Image;
use Aws\Rekognition\RekognitionClient;
use SimpleSoftwareIO\QrCode\Facades\QrCode;
use App\Http\Controllers\Auth\AuthenticatedSessionController;
// require 'vendor/autoload.php';

class OrganizadorController extends Controller
{

    public function index()
    {
        $id = auth()->user()->id;
        // dd($id);
        $event = Evento::where('id_organizador', '=', $id)->get();
        $coleccion = collect([]);
        // dd($coleccion);
        foreach ($event as $e) {
            // dd($e);
            $album = album_evento::where('id_evento', '=', $e->id)
                ->where('estado', '=', 1)->first();
            // dd($album);
            if (!is_null($album)) {
                $coleccion = $coleccion->merge($album->id);
            }
        }
        // dd($coleccion);
        $albunes = album_evento::get();
        // dd($coleccion);
        $eventos = Evento::join('users', 'users.id', 'eventos.id_fotoestudio')
            ->join('album_eventos', 'album_eventos.id_evento', '=', 'eventos.id')
            ->where('album_eventos.estado', '=', '0')
            ->select('eventos.*', 'users.name as fotoestudio', 'users.profile_photo_path as fotostudio_perfil', 'album_eventos.id as id_album_evento')->get();
        // dd($eventos);
        $evento2s = Evento::join('users', 'users.id', 'eventos.id_fotoestudio')
            ->join('album_eventos', 'album_eventos.id_evento', '=', 'eventos.id')
            ->where('album_eventos.estado', '=', '1')
            ->select('eventos.*', 'users.name as fotoestudio', 'users.profile_photo_path as fotostudio_perfil', 'album_eventos.id as id_album_evento')->get();
        // dd($eventos);

        // seccion para saver la cantidad de envitados que tiene mi evento
        $invitados = 0;
        foreach ($eventos as $e) {
            $i = invitacion_evento::where('id_evento', '=', $e->id)->first();
            $invitados = $invitados + 1;
        }

        return view('VistaEventos.index', compact('eventos', 'evento2s', 'coleccion', 'albunes', 'invitados'));
    }

    public function crearEvento()
    {
        $fotoestudios = User::all();
        return view('VistaEventos.create', compact('fotoestudios'));
    }

    //creo el evento
    public function store(Request $request)
    {
        // dd($request);
        $id = auth()->user()->id;
        // seccion foto del evento
        if ($request->hasFile('foto')) {
            $file = $request->file('foto');
            $destino = 'img/Eventos/';
            $foto = time() . '-' . $file->getClientOriginalName();
            $subirImagen = $request->file('foto')->move($destino, $foto);
        } else {
            $foto = "default.png";
        }

        // seccion evento
        $e = new Evento();
        $e->evento_name = $request->evento_name;
        $e->descripcion = $request->descripcion;
        $e->fecha = $request->fecha;
        $e->hora = $request->hora;
        $e->horafin = $request->horafin;
        $e->lugar = $request->lugar;
        $e->estado = '0';   //  Activo = 0 | Terminado = 1
        $e->id_organizador = $id;
        $e->id_fotoestudio = $request->fotoestudio;
        $e->foto = $foto;
        $e->save();

        // seccion album del evento
        $a = new album_evento();
        $a->nombre_album = $request->evento_name;
        $a->descripcion = $request->descripcion;
        $a->portada = $foto;
        $a->estado = '0'; //pendiente (no tiene fotos cargadas)
        $a->id_evento = $e->id;
        $a->save();


        // seccion poner en ocupado al fotografo
        $estado = User::where('id', '=', $request->fotoestudio)->first();
        $estado->estado = 1;
        $estado->save();

        // seccion de renderizar imagen de portada del evento
        // $img = Image::make($request->file('foto'))
        //     ->resize(300, null, function ($constraint) {
        //         $constraint->aspectRatio();
        //     })->insert('public/img/watermark.png')->save($destino . $foto);

        // seccion de invitacion
        // genero el qr de la invitacion
        // $qr = QrCode::format('png')->size(500)->generate('Estas Invitado a ' . $request->evento_name, '../public/qrcodes/' . $foto);
        // paso la invitacion a todos los usuarios con rol cliente
        // $u = User::get();
        // foreach ($u as $c) {
        //     if ($c->getRole() == 2) {
        //         $i = new invitacion_evento();
        //         $i->entrada_qr = $foto;
        //         $i->id_cliente = $c->id;
        //         $i->id_evento = $e->id;
        //         $i->save();
        //     }
        // }

        return redirect()->route('organizadores.index');
    }

    /**
     * Display the specified resource.
     */
    public function show(organizador $organizador)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(organizador $organizador)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, organizador $organizador)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(organizador $organizador)
    {
        //
    }

    public function reportes()
    {
        return view('VistaReportes.organizadores');
    }

    public function aprobadoTodo(Request $r)
    {
        // dd($r);
        // $id = auth()->user()->id;
        $fotos = fotos::where('id_album_evento', '=', $r->id)->get();
        // $a = Evento::join('album_eventos', 'album_eventos.id_evento', '=', 'eventos.id')
        //     ->where('album_eventos.id', '=', $r->id)
        //     ->where('eventos.id_fotoestudio', $id)
        //     ->select('eventos.*', 'album_eventos.id as id_album_evento')->first();
        // dd($eventos);

        return view('VistaEventos.aprobar', compact('fotos'));
    }


    function obtenerNombreImagen($url)
    {
        $parts = parse_url($url);
        $path = explode('/', $parts['path']);
        $nombreImagen = 'ruta/' . end($path);
        // dd($nombreImagen);
        return $nombreImagen;
    }

    public function compararFotos($fotoSubidas)
    {
        set_time_limit(120); // Establecer el límite de tiempo de ejecución en 120 segundos (2 minutos)

        // dd($fotoSubidas);
        $fotosAlmacenadas = [];
        $fotos_perfil = User::all();
        foreach ($fotos_perfil as $f) {
            $fotosAlmacenadas[] = $f->profile_photo_path;
        }


        $rekognition = new RekognitionClient([
            'version' => 'latest',
            'region' => 'us-east-1',
            'credentials' => [
                'key' => 'AKIAYJVJS4X563AM7AFW',
                'secret' => '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',
            ],
        ]);

        // no muestra imagenes porque rekognition no puede acceder a la imagen local,
        //tiene que estar en un bucket de s3 o en una url en linea

        foreach ($fotoSubidas as $fotoSubida) {
            foreach ($fotosAlmacenadas as $perfil) {

                $resultado = $rekognition->CompareFaces([
                    'SimilarityThreshold' => 70,
                    'SourceImage' => [
                        'S3Object' => [
                            'Bucket' => 'julico-bucket03',
                            'Name' => $this->obtenerNombreImagen($perfil),
                        ],
                    ],
                    'TargetImage' => [
                        'S3Object' => [
                            'Bucket' => 'julico-bucket03',
                            'Name' => $this->obtenerNombreImagen($fotoSubida),
                        ],
                    ],
                ]);

                if ($resultado['FaceMatches']) {
                    $usuario = User::where('profile_photo_path', '=', $perfil)->first();
                    $foto = fotos::where('foto_original', '=', $fotoSubida)->first();

                    $detalle = new similitud();
                    $detalle->id_usuario = $usuario->id;
                    $detalle->id_foto = $foto->id;
                    $detalle->estado = 0;
                    $detalle->save();
                }
            }
        }


        // if (!empty($faceMatches)) {
        //     foreach ($faceMatches as $match) {
        //         $similarity = $match['Similarity'];
        //         echo "Rostros similares encontrados. Similitud: " . $similarity . "%";
        //     }
        // } else {
        //     echo "No se encontraron rostros similares en las imágenes.";
        // }



        // foreach ($/fotoSubidas as $fotoSubida) {
        //     foreach ($fotosAlmacenadas as $perfil) {
        //         $resultado = $rekognition->compareFaces([
        //             'SimilarityThreshold' => 70,
        //             'SourceImage' => [
        //                 'S3Object' => [
        //                     'Bucket' => 'julico-bucket03',
        //                     'Name' => 'ruta/64685dab36e29.png',
        //                 ],
        //             ],
        //             'TargetImage' => [
        //                 'S3Object' => [
        //                     'Bucket' => 'julico-bucket03',
        //                     'Name' => 'ruta/64685dab36e29.png',
        //                 ],
        //             ],
        //         ]);

        //         $faceMatches = $resultado['FaceMatches'];
        //         $coleccion = $coleccion->merge($faceMatches);
        //     }
        // }
        return view('VistaEventos.index');
    }


    public function aprobadoTodoStore(Request $request)
    {
        // dd($request);

        $fotos_aprobadas = [];
        foreach ($request->fotos as $id => $value) {

            $id_album = substr($value, -1);
            $album = album_evento::where('id', '=', $id_album)->first();
            $album->estado = 2;  //  Pendiente = 0 | Cargado = 1 | Aprobado = 2
            $album->save();

            if (strpos($value, 'aprobada') !== false) {
                // dd($id);
                // dd("estoy en aprobado");

                $foto = fotos::where('id', '=', $id)->first();
                $foto->estado = 1;  //  Pendiente = 0 | Aprobado = 1 | Rechazado = 2
                $foto->save();

                $fotos_aprobadas[] =  $foto->foto_original;
            } elseif (strpos($value, 'rechazada') !== false) {
                // $fotos_rechazadas[] = $id;

                $foto = fotos::where('id', '=', $id)->first();
                $foto->estado = 2;  //  Pendiente = 0 | Aprobado = 1 | Rechazado = 2
                $foto->save();
            }
        }
        // dd($fotos_rechazadas);
        // dd($fotos_aprobadas);
        $this->compararFotos($fotos_aprobadas);

        return redirect()->route('organizadores.index')->with('success', 'Fotos aprobadas correctamente');
    }
}
