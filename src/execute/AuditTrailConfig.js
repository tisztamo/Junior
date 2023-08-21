let warned = false;

export default function AuditTrailConfig() {
    const enabled = !process.argv.includes('--noaudit');
    if (!enabled && !warned) {
        console.warn('Warning: Audit trail is disabled.');
        warned = true;
    }
    return { enabled };
}
