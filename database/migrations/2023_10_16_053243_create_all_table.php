<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('master_role', function (Blueprint $table) {
            $table->id();
            $table->string('name');
        });

        Schema::create('user', function (Blueprint $table) {
            $table->id();
            $table->string('username');
            $table->string('password');
            $table->string('fullname');
            $table->string('address');
            $table->string('nip')->nullable();
            $table->string('nik')->nullable();
        });

        Schema::create('user_role', function (Blueprint $table) {
            $table->id();
            $table->foreignId('id_user')->unsigned();
            $table->foreignId('id_role')->unsigned();
            $table->foreign('id_user')->references('id')->on('user');
            $table->foreign('id_role')->references('id')->on('master_role');
        });

        Schema::create('master_mapel', function (Blueprint $table) {
            $table->id();
            $table->string('name');
        });

        Schema::create('master_kelas', function (Blueprint $table) {
            $table->id();
            $table->string('name');
        });

        Schema::create('mapping_mapel', function (Blueprint $table) {
            $table->id();
            $table->foreignId('id_user')->unsigned();
            $table->foreignId('id_mapel')->unsigned();
            $table->foreignId('id_kelas')->unsigned();
            $table->foreign('id_user')->references('id')->on('user');
            $table->foreign('id_mapel')->references('id')->on('master_mapel');
            $table->foreign('id_kelas')->references('id')->on('master_kelas');
            $table->float('kkm');
            $table->string('semester');
            $table->string('tahun');
        });

        Schema::create('student_kelas', function (Blueprint $table) {
            $table->id();
            $table->foreignId('id_user')->unsigned();
            $table->foreignId('id_kelas')->unsigned();
            $table->foreign('id_user')->references('id')->on('user');
            $table->foreign('id_kelas')->references('id')->on('master_kelas');
        });

        Schema::create('mapel_report', function (Blueprint $table) {
            $table->id();
            $table->foreignId('id_mapping_mapel')->unsigned();
            $table->foreignId('id_user')->unsigned();
            $table->foreign('id_mapping_mapel')->references('id')->on('mapping_mapel');
            $table->foreign('id_user')->references('id')->on('user');
            $table->float('nilai');
        });

        Schema::create('master_ekskul', function (Blueprint $table) {
            $table->id();
            $table->string('name');
        });

        Schema::create('mapping_ekskul', function (Blueprint $table) {
            $table->id();
            $table->foreignId('id_ekskul')->unsigned();
            $table->foreignId('id_user')->unsigned();
            $table->foreign('id_ekskul')->references('id')->on('master_ekskul');
            $table->foreign('id_user')->references('id')->on('user');
            $table->string('semester');
            $table->string('tahun');
        });

        Schema::create('ekskul_report', function (Blueprint $table) {
            $table->id();
            $table->foreignId('id_mapping_ekskul')->unsigned();
            $table->foreign('id_mapping_ekskul')->references('id')->on('mapping_ekskul');
            $table->float('nilai');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('user_role');
        Schema::dropIfExists('student_kelas');
        Schema::dropIfExists('mapel_report');
        Schema::dropIfExists('ekskul_report');
        Schema::dropIfExists('mapping_mapel');
        Schema::dropIfExists('mapping_ekskul');
        Schema::dropIfExists('user');
        Schema::dropIfExists('master_kelas');
        Schema::dropIfExists('master_ekskul');
        Schema::dropIfExists('master_mapel');
        Schema::dropIfExists('master_role');
    }
};
