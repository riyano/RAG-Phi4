<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('sessions', function (Blueprint $table) {
            $table->string('id')->primary(); // ID sesi yang unik
            $table->foreignId('user_id')->nullable()->index(); // ID pengguna jika sudah login
            $table->string('ip_address', 45)->nullable(); // Alamat IP pengguna
            $table->text('user_agent')->nullable(); // Info browser pengguna
            $table->longText('payload'); // Data sesi yang dienkripsi
            $table->integer('last_activity')->index(); // Waktu aktivitas terakhir
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('sessions');
    }
};