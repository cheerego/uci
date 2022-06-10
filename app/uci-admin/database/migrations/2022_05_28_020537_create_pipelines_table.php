<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreatePipelinesTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('pipelines', function (Blueprint $table) {
            $table->id();
            $table->integer("workflow_id");
            $table->text("yaml")->default("");
            $table->string("salt")->default("");
            $table->timestamp("last_dispatch_time")->nullable();
            $table->integer("dispatch_times")->default(0);
            $table->string("status")->default("Queuing");
            $table->string("status_message")->default("");
            $table->string("uuid")->default("");
            $table->text("raw_log")->default("");
            $table->json("envs");
            $table->timestamps();
            $table->softDeletes();

        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('pipelines');
    }
}
