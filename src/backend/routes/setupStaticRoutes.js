import path from 'path';
import express from 'express';
import getProjectRoot from '../fileutils/getProjectRoot';

export function setupStaticRoutes(app) {
    const projectRoot = getProjectRoot();
    const frontendDistPath = path.join(projectRoot, 'dist', 'frontend');
    app.use('/', express.static(frontendDistPath));
}
