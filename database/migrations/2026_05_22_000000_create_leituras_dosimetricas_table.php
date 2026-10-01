<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('leituras_dosimetricas', function (Blueprint $table) {
            $table->increments('id');
            $table->unsignedInteger('professional_id');
            $table->date('mes_referencia');
            $table->decimal('valor_msv', 8, 3);
            $table->string('tipo')->nullable();
            $table->text('observacoes')->nullable();
            $table->string('faixa')->nullable();
            $table->text('conduta')->nullable();
            $table->string('prazo')->nullable();
            $table->timestamps();
            $table->softDeletes();

            $table->unique(['professional_id', 'mes_referencia'], 'leituras_dosimetricas_prof_mes_unique');
            $table->foreign('professional_id')
                ->references('id')->on('professionals')
                ->onDelete('cascade');
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('leituras_dosimetricas');
    }
};
