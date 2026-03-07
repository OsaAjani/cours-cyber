<?php
    require_once 'incs/JWT.php';

    $secret = 'SOME_SECRET_KEY';

    $jwt = $_COOKIE['token'] ?? null;
    if (!$jwt) {
        $jwt = JWT::encode(['role' => 'guest'], $secret, 'HS256');
        setcookie('token', $jwt, time() + 3600, '/');
    }

    try {
        $jwt_decoded = JWT::decode($jwt, $secret);
    } catch (Exception $e) {
        $jwt_decoded = (object) ['role' => 'invalid'];
    }
    
    $role = $jwt_decoded->role ?? 'unknown';

    require 'templates/index.php';