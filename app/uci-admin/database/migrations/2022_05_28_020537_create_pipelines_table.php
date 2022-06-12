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
            $table->integer("number")->default(0);
            $table->text("yaml")->default("");
            $table->string("salt")->default("");

            $table->integer("runner_id")->default(0);

            $table->string("status")->default("BUILD_QUEUING");
            $table->string("status_message")->default("");
            $table->string("uuid")->default("");
            $table->json("envs")->default("[]");


            $table->text("raw_log")->default("");
            $table->text("prepare_log")->default("");

            $table->integer("dispatch_times")->default(0);
            $table->timestamp("last_dispatch_at")->nullable();
            $table->timestamp("dispatch_success_at")->nullable();
            $table->timestamp("last_use_at")->nullable();

            $table->timestamp("started_at")->nullable();
            $table->timestamp("closed_at")->nullable();
            $table->integer("duration")->default(0);

            $table->integer("release_runner_at")->nullable();


            $table->json("time_consuming")->nullable();


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
