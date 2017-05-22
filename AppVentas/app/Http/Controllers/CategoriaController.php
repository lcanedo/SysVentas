<?php

namespace SysVentas\Http\Controllers;

use Illuminate\Http\Request;

use SysVentas\Http\Requests;

use SysVentas\Categoria;
use Illuminate\Support\Facades\Redirect;
use SysVentas\Http\Requests\CategoriaFormRequest;
use DB;

class CategoriaController extends Controller
{
    public function __constructor(){}

    public function index(Request $request){
        if ($request) {
            //trim es para quitar los espacios de entra y salida
            $query=trim($request->get('searchText'));//filtrar texto de busqueda para todas las categorias
            $categoria=DB::table('categoria')->where('nombre','LIKE','%'.$query.'%')
            ->where('condicion', '=','1')
            ->orderBy('idcategoria','desc')
            ->paginate(7);
            return view('almacen.categoria.index',["categorias"=>$categoria,"searchText"=>$query]);
        }
    }
    
    //enviar datos de formularios a base de datos tipo get
    public function create(){
        return view("almacen.categoria.create");//renviar a otra agina para insertar datos
    }
    //enviar datos de formularios a base de datos tipo post
    public function store(CategoriaFormRequest $request){
        $categoria = new Categoria;
        $categoria->nombre=$request->get('nombre');
        $categoria->descripcion=$request->get('descripcion');
        $categoria->condicion='1';
        $categoria->save();
        return Redirect::to('almacen/categoria');
    }
    //recuperacion de datos de un registro en particular de l abase de datos
    public function show($id){
        return view("almacen.categoria.show",["categoia"=>Categoria::findOrFail($id)]);
    }
    //editar un registro de bases de datos via get
    public function edit($id){
        return view("almacen.categoria.edit",["categoia"=>Categoria::findOrFail($id)]);
    }
    //accion que modifique ese registro y es de por put
    public function update(CategoriaFormRequest $request, $id){
        $categoria=Cateoria::findOrFail($id);
        $categoria->nombre=$request->get('nombre');
        $categoria->descripcion=$request->get('descripcion');
        $categoria->update();
        return view('almacen/categoria');
    }
    //borra un registro en base de datos
    public function destroy($id){
        $categoria=Categoria::findOrFail($id);
        $categoria->condicion='0';
        $categoria->update();
        return Redirect::to('almacen/categoria');
        
    }
}
