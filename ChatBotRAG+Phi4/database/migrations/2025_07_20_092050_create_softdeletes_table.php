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
    Schema::create('softdeletes', function (Blueprint $table) {
        $table->id();
        $table->unsignedBigInteger('user_id')->nullable(); // Dari user_id asli
        $table->string('session_id')->nullable(); // Dari session_id asli
        $table->string('original_filename');
        $table->string('stored_path');
        $table->timestamps(); // Kapan record ini dibuat
        $table->timestamp('deleted_at')->useCurrent(); // Kapan record ini dihapus
    });
}

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('softdeletes');
    }
};
