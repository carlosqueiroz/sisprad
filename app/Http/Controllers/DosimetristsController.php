<?php

namespace App\Http\Controllers;

use Exception;
use Illuminate\Database\Eloquent\SoftDeletes;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use TCG\Voyager\Database\Schema\SchemaManager;
use TCG\Voyager\Events\BreadDataAdded;
use TCG\Voyager\Events\BreadDataDeleted;
use TCG\Voyager\Events\BreadDataRestored;
use TCG\Voyager\Events\BreadDataUpdated;
use TCG\Voyager\Events\BreadImagesDeleted;
use TCG\Voyager\Facades\Voyager;
use TCG\Voyager\Http\Controllers\Traits\BreadRelationshipParser;


class DosimetristsController extends \TCG\Voyager\Http\Controllers\VoyagerBaseController
{

    public function getProfessionals(Request $request){
       


            // Supondo que 'setor_id' corresponda a uma coluna na sua tabela 'professionals'
            $setorId = $request->input('sector_id');


            $query = DB::table('professionals')
                ->select(
                'professionals.id as person_id','professionals.person_name',
                 'professionals.person_cpf','dosimetros.id as dosimetro',
                 'dosimetros.tipo as tipo', 'dosimetros.usa_avental as avental'
                 )
                 ->leftJoin('sector_professionals','professionals.id','=','sector_professionals.professional_id')
                 ->leftJoin('sectors','sectors.id','=','sector_professionals.sector_id')
                 ->leftJoin('dosimetros', 'professionals.id','=','dosimetros.profissional_id')
                 ->where('sectors.id', $setorId)
                ->get();

 
 

            return response()->json($query);

    }
   
}