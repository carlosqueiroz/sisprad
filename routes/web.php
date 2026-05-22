<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return redirect('/admin');

});


Route::group(['prefix' => 'admin'], function () {
    Voyager::routes();

    Route::get('medt/dashboard', [\App\Http\Controllers\MedtController::class, 'dashboard'])->name('medt.dashboard');
    Route::get('medt/import', [\App\Http\Controllers\MedtController::class, 'importForm'])->name('medt.import.form');
    Route::post('medt/import', [\App\Http\Controllers\MedtController::class, 'importSubmit'])->name('medt.import.submit');
});


Route::get('/arquivos', function () {
    return view('files');
});

 

Route::get('professionals', 'App\Http\Controllers\DosimetristsController@getProfessionals');
