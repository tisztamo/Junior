import path from 'path';
import express from 'express';

export function setupStaticRoutes(app) {
    const projectRoot = path.resolve(new URL(import.meta.url).pathname, '..', '..', '..', '..');
    const frontendDistPath = path.join(projectRoot, 'dist', 'frontend');
    app.use('/', express.static(frontendDistPath));
}
