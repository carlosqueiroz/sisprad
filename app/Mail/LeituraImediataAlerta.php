<?php

namespace App\Mail;

use App\LeituraDosimetrica;
use Illuminate\Bus\Queueable;
use Illuminate\Mail\Mailable;
use Illuminate\Queue\SerializesModels;

class LeituraImediataAlerta extends Mailable
{
    use Queueable, SerializesModels;

    public function __construct(public LeituraDosimetrica $leitura)
    {
    }

    public function build(): self
    {
        $prof = $this->leitura->professional;
        $assunto = sprintf(
            '[MEDt] Alerta — Conduta imediata para %s (faixa %s)',
            $prof?->person_name ?? 'profissional',
            $this->leitura->faixa
        );

        return $this->subject($assunto)
            ->view('emails.medt.leitura_imediata')
            ->with([
                'leitura'      => $this->leitura,
                'professional' => $prof,
            ]);
    }
}
