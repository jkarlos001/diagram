<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <style>
    </style>
    <link rel="stylesheet" href="{{ resource_path('css/exportar.css') }}">
    <title>Postgres</title>
</head>

<body>
    <div class="container mx-auto px-4">
        <div class="bg-white rounded-lg shadow-lg p-6">
            <div class="mb-4">
                <h2 class="text-2xl font-bold">Creation script (Postgres)</h2>
            </div>
            <div class="mb-4">
                {{-- <p class="text-lg font-mono">texto de prueba</p> --}}
                <p class="text-lg">CREATE DATABASE {{ $di->titulo }};</p>
                <p class="text-lg mb-10">\c {{ $di->titulo }};</p>

                {{-- @dd($array_clase) --}}
                @forelse ($array_clase as $tabla)
                    <p class="text-lg my-0">CREATE TABLE {{ $tabla['clase_name'] }} {</p>
                    {{-- <p class="text-lg my-0">{</p> --}}
                    {{-- @dd($tabla->relations, $tabla->atributos) --}}
                    @foreach ($tabla['atributos'] as $atributos)
                        {{-- @dd($tabla['atributos']) --}}

                        {{-- @if ($tabla['atributos']) --}}
                        @if ($atributos['atributo_name'] == 'id')
                            <p class="text-lg ml-4 my-0">{{ $atributos['atributo_name'] }} SERIAL PRIMARY KEY,</p>
                        @else
                            @switch($atributos["tipo_dato_name"])
                                @case('Texto')
                                    <p class="text-lg ml-4 my-0">{{ $atributos['atributo_name'] }} VARCHAR(100) NOT NULL,</p>
                                @break

                                @case('Numerico')
                                    <p class="text-lg ml-4 my-0">{{ $atributos['atributo_name'] }} INT NOT NULL,</p>
                                @break

                                @case('Fecha')
                                    <p class="text-lg ml-4 my-0">{{ $atributos['atributo_name'] }} DATE NOT NULL,</p>
                                @break

                                @case('Llave Foranea')
                                    <p class="text-lg ml-4 my-0">{{ $atributos['atributo_name'] }} INT NOT NULL,</p>
                                    @if (!is_null($tabla['relaciones']))
                                        @forelse ($tabla['relaciones'] as $rel)
                                            <p class="text-lg ml-4 my-0">FOREIGN KEY ({{ $atributos['atributo_name'] }})
                                                REFERENCES
                                                {{ $rel['clase_destino'] }}(id),</p>
                                        @empty
                                        @endforelse
                                    @else
                                    @endif
                                @break

                                @default
                                    <p class="text-lg ml-4 text-red-500">error,</p>
                            @endswitch
                        @endif
                        {{-- @endif --}}
                    @endforeach
                    <p class="text-lg mt-0 mb-10">};</p>
                    @empty

                        <p class="text-lg">error</p>
                    @endforelse

                </div>
            </div>
        </div>
    </body>

    </html>
