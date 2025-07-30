<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::table('datasets', function (Blueprint $table) {
            // Membuat aturan unik untuk user yang login
            $table->unique(['user_id', 'original_filename']);
            // Membuat aturan unik untuk user guest
            $table->unique(['session_id', 'original_filename']);
        });
    }

    public function down(): void
    {
        Schema::table('datasets', function (Blueprint $table) {
            $table->dropUnique(['user_id', 'original_filename']);
            $table->dropUnique(['session_id', 'original_filename']);
        });
    }
};